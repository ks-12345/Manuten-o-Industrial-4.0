<?php

namespace App\Services;

use App\Enums\RespostaChecklist;
use App\Enums\TipoChecklist;
use App\Enums\TipoResposta;
use App\Models\ChecklistModelo;
use App\Models\ChecklistPergunta;
use App\Models\Maquina;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class ChecklistService
{
    public function criarChecklistParaMaquina(
        Maquina $maquina,
        TipoChecklist $tipo,
        array $perguntas = [],
        ?ChecklistModelo $template = null,
        ?string $nome = null,
    ): ChecklistModelo {
        if ($tipo !== TipoChecklist::Inspecao && ! $this->maquinaTemInspecao($maquina)) {
            throw ValidationException::withMessages([
                'checklists' => 'Não é permitido criar checklist corretivo ou preventivo sem checklist de inspeção.',
            ]);
        }

        return DB::transaction(function () use ($maquina, $tipo, $perguntas, $template, $nome) {
            $modelo = ChecklistModelo::create([
                'nome' => $nome ?? $this->nomePadrao($maquina, $tipo),
                'descricao' => $template?->descricao,
                'tipo' => $tipo,
                'maquina_id' => $maquina->id,
                'tipo_maquina_id' => $maquina->tipo_maquina_id,
                'template_padrao' => false,
                'ativo' => true,
            ]);

            $origemPerguntas = $template
                ? $template->perguntas()->get()->pluck('pergunta')->all()
                : $perguntas;

            $this->criarPerguntas($modelo, $origemPerguntas);

            return $modelo;
        });
    }

    public function criarChecklistsSelecionados(Maquina $maquina, array $tipos): void
    {
        $tipos = collect($tipos)->filter()->values();

        if ($tipos->contains(TipoChecklist::Corretiva->value) || $tipos->contains(TipoChecklist::Preventiva->value)) {
            $tipos = $tipos->prepend(TipoChecklist::Inspecao->value)->unique()->values();
        }

        foreach ($tipos as $tipo) {
            $tipoEnum = $tipo instanceof TipoChecklist ? $tipo : TipoChecklist::from($tipo);

            if ($maquina->checklistModelos()->porTipo($tipoEnum)->exists()) {
                continue;
            }

            $template = $this->templateParaMaquina($maquina, $tipoEnum);
            $this->criarChecklistParaMaquina($maquina, $tipoEnum, template: $template);
        }
    }

    public function templateParaMaquina(Maquina $maquina, TipoChecklist $tipo): ?ChecklistModelo
    {
        return ChecklistModelo::query()
            ->ativos()
            ->porTipo($tipo)
            ->whereNull('maquina_id')
            ->where(function ($query) use ($maquina) {
                $query->where('tipo_maquina_id', $maquina->tipo_maquina_id)
                    ->orWhereNull('tipo_maquina_id');
            })
            ->orderByDesc('template_padrao')
            ->orderByRaw('case when tipo_maquina_id is null then 0 else 1 end desc')
            ->first();
    }

    public function modeloParaMaquina(Maquina $maquina, TipoChecklist $tipo): ?ChecklistModelo
    {
        return ChecklistModelo::query()
            ->ativos()
            ->porTipo($tipo)
            ->where('maquina_id', $maquina->id)
            ->first()
            ?? $this->templateParaMaquina($maquina, $tipo);
    }

    public function salvarRespostas(Model $checklistable, ChecklistModelo $modelo, array $respostas): void
    {
        $perguntas = $modelo->perguntas()->get();

        foreach ($perguntas as $pergunta) {
            $data = $respostas[$pergunta->id] ?? [];
            $resposta = $data['resposta'] ?? null;

            if (! in_array($resposta, array_column(RespostaChecklist::cases(), 'value'), true)) {
                throw ValidationException::withMessages([
                    "checklistRespostas.{$pergunta->id}.resposta" => 'Todas as perguntas do checklist devem ser respondidas.',
                ]);
            }

            if ($resposta === RespostaChecklist::NaoConforme->value && (blank($data['evidencia'] ?? null) || blank($data['descricao'] ?? null))) {
                throw ValidationException::withMessages([
                    "checklistRespostas.{$pergunta->id}.descricao" => 'Não conformidade exige evidência e descrição.',
                ]);
            }
        }

        DB::transaction(function () use ($checklistable, $perguntas, $respostas) {
            foreach ($perguntas as $pergunta) {
                $data = $respostas[$pergunta->id];

                $checklistable->checklistRespostas()->updateOrCreate(
                    ['checklist_pergunta_id' => $pergunta->id],
                    [
                        'resposta_enum' => $data['resposta'],
                        'evidencia' => $data['evidencia'] ?? null,
                        'descricao' => $data['descricao'] ?? null,
                        'foto' => $data['evidencia'] ?? null,
                        'observacao' => $data['descricao'] ?? null,
                    ]
                );
            }
        });
    }

    public function criarPerguntas(ChecklistModelo $modelo, array $perguntas): void
    {
        foreach (array_values(array_filter($perguntas)) as $index => $pergunta) {
            ChecklistPergunta::create([
                'checklist_modelo_id' => $modelo->id,
                'pergunta' => trim((string) $pergunta),
                'tipo_resposta' => TipoResposta::OkProblema,
                'obrigatoria' => true,
                'ordem' => $index + 1,
            ]);
        }
    }

    public function maquinaTemInspecao(Maquina $maquina): bool
    {
        return $maquina->checklistModelos()
            ->porTipo(TipoChecklist::Inspecao)
            ->exists();
    }

    private function nomePadrao(Maquina $maquina, TipoChecklist $tipo): string
    {
        return "{$tipo->getLabel()} - {$maquina->nome}";
    }
}
