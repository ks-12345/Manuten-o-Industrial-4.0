<?php

namespace Database\Seeders;

use App\Enums\TipoChecklist;
use App\Enums\TipoResposta;
use App\Models\ChecklistModelo;
use App\Models\Maquina;
use Illuminate\Database\Seeder;

class MaintSysDemoChecklistSeeder extends Seeder
{
    public function run(): void
    {
        Maquina::query()
            ->orderBy('id')
            ->each(function (Maquina $maquina): void {
                $this->criarChecklistInspecao($maquina);
                $this->criarChecklistCorretiva($maquina);
            });
    }

    private function criarChecklistInspecao(Maquina $maquina): void
    {
        $modelo = ChecklistModelo::query()->firstOrCreate(
            [
                'maquina_id' => $maquina->id,
                'tipo' => TipoChecklist::Inspecao,
                'nome' => 'Inspeção técnica padrão',
            ],
            [
                'descricao' => 'Checklist base para diagnóstico técnico inicial.',
                'ativo' => true,
            ],
        );

        $this->syncPerguntas($modelo, [
            ['ordem' => 10, 'pergunta' => 'Máquina energiza e responde aos comandos?', 'tipo_resposta' => TipoResposta::OkProblema],
            ['ordem' => 20, 'pergunta' => 'Há ruído, vibração ou aquecimento anormal?', 'tipo_resposta' => TipoResposta::SimNao],
            ['ordem' => 30, 'pergunta' => 'Condição visual de cabos, proteções e sensores', 'tipo_resposta' => TipoResposta::Observacao],
            ['ordem' => 40, 'pergunta' => 'Registro fotográfico da condição encontrada', 'tipo_resposta' => TipoResposta::Foto, 'obrigatorio' => false],
        ]);
    }

    private function criarChecklistCorretiva(Maquina $maquina): void
    {
        $modelo = ChecklistModelo::query()->firstOrCreate(
            [
                'maquina_id' => $maquina->id,
                'tipo' => TipoChecklist::Corretiva,
                'nome' => 'Corretiva técnica padrão',
            ],
            [
                'descricao' => 'Checklist base para validar execução e liberação da máquina.',
                'ativo' => true,
            ],
        );

        $this->syncPerguntas($modelo, [
            ['ordem' => 10, 'pergunta' => 'Falha corrigida e causa provável registrada?', 'tipo_resposta' => TipoResposta::OkProblema],
            ['ordem' => 20, 'pergunta' => 'Teste funcional executado com a máquina em condição segura?', 'tipo_resposta' => TipoResposta::OkProblema],
            ['ordem' => 30, 'pergunta' => 'Parâmetros, proteções e intertravamentos conferidos?', 'tipo_resposta' => TipoResposta::OkProblema],
            ['ordem' => 40, 'pergunta' => 'Observações finais da intervenção', 'tipo_resposta' => TipoResposta::Texto, 'obrigatorio' => false],
        ]);
    }

    private function syncPerguntas(ChecklistModelo $modelo, array $perguntas): void
    {
        foreach ($perguntas as $pergunta) {
            $modelo->perguntas()->updateOrCreate(
                ['ordem' => $pergunta['ordem']],
                [
                    'pergunta' => $pergunta['pergunta'],
                    'tipo_resposta' => $pergunta['tipo_resposta'],
                    'obrigatorio' => $pergunta['obrigatorio'] ?? true,
                    'ajuda' => $pergunta['ajuda'] ?? null,
                    'ativo' => true,
                ],
            );
        }
    }
}
