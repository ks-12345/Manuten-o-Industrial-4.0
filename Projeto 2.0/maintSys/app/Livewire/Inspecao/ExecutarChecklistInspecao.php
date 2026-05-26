<?php

namespace App\Livewire\Inspecao;

use App\Enums\TipoChecklist;
use App\Enums\TipoResposta;
use App\Models\ChecklistModelo;
use App\Models\ChecklistPergunta;
use App\Models\ChecklistResposta;
use App\Models\Inspecao;
use App\Models\Maquina;
use App\Services\InspecaoService;
use Filament\Notifications\Notification;
use Illuminate\Support\Arr;
use Illuminate\Support\Collection;
use Livewire\Attributes\Computed;
use Livewire\Component;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;
use Livewire\WithFileUploads;

class ExecutarChecklistInspecao extends Component
{
    use WithFileUploads;

    public string $inspecaoId;

    public array $respostas = [];

    public ?bool $outro_problema = null;

    public ?string $descricao_outro_problema = null;

    public function mount(string $inspecaoId): void
    {
        $this->inspecaoId = $inspecaoId;

        $inspecao = Inspecao::query()->findOrFail($inspecaoId);

        $this->outro_problema = (bool) $inspecao->outro_problema;
        $this->descricao_outro_problema = $inspecao->descricao_outro_problema;

        $this->respostas = $inspecao->respostas()
            ->with('pergunta')
            ->get()
            ->mapWithKeys(function (ChecklistResposta $resposta): array {
                return [
                    $resposta->checklist_pergunta_id => [
                        'conforme' => $resposta->conforme,
                        'resposta' => $resposta->resposta,
                        'observacao' => $resposta->observacao,
                        'foto' => $resposta->foto,
                    ],
                ];
            })
            ->toArray();
    }

    #[Computed]
    public function inspecao(): Inspecao
    {
        return Inspecao::query()
            ->with(['ocorrencia.maquina', 'respostas.pergunta'])
            ->findOrFail($this->inspecaoId);
    }

    #[Computed]
    public function maquina(): Maquina
    {
        return $this->inspecao->ocorrencia->maquina;
    }

    #[Computed]
    public function checklistModelo(): ?ChecklistModelo
    {
        return ChecklistModelo::query()
            ->where('ativo', true)
            ->where('tipo', TipoChecklist::Inspecao)
            ->where('maquina_id', $this->maquina->id)
            ->first();
    }

    /** @return Collection<int, ChecklistPergunta> */
    #[Computed]
    public function perguntas(): Collection
    {
        if (! $this->checklistModelo) {
            return collect();
        }

        return ChecklistPergunta::query()
            ->where('checklist_modelo_id', $this->checklistModelo->id)
            ->where('ativo', true)
            ->orderBy('ordem')
            ->get();
    }

    public function setResposta(int $perguntaId, bool $conforme): void
    {
        $this->respostas[$perguntaId] = array_merge(
            $this->respostas[$perguntaId] ?? [],
            ['conforme' => $conforme],
        );
    }

    public function salvarChecklist(): void
    {
        $inspecao = $this->inspecao;
        $modelo = $this->checklistModelo;

        if (! $modelo) {
            Notification::make()
                ->danger()
                ->title('Checklist não configurado')
                ->body('Nenhum checklist ativo encontrado para a máquina e tipo de inspeção.')
                ->send();

            return;
        }

        $dadosResposta = [];

        foreach ($this->perguntas as $pergunta) {
            $resposta = $this->respostas[$pergunta->id] ?? [];
            $fotoPath = $this->storeFoto($resposta['foto'] ?? null);

            $payload = [
                'checklist_pergunta_id' => $pergunta->id,
                'tecnico_id' => auth()->id(),
                'resposta' => '',
                'observacao' => $resposta['observacao'] ?? null,
                'foto' => $fotoPath,
            ];

            if ($pergunta->tipo_resposta === TipoResposta::Texto) {
                $payload['resposta'] = (string) ($resposta['resposta'] ?? '');
            } elseif ($pergunta->tipo_resposta === TipoResposta::Observacao) {
                $payload['resposta'] = (string) ($resposta['observacao'] ?? '');
            } elseif ($pergunta->tipo_resposta === TipoResposta::Foto) {
                $payload['resposta'] = $fotoPath ?? '';
            } else {
                $payload['conforme'] = (bool) ($resposta['conforme'] ?? false);
                $payload['resposta'] = $payload['conforme'] ? 'ok' : 'problema';
            }

            $dadosResposta[] = $payload;
        }

        $existing = $inspecao->respostas()->get()->keyBy('checklist_pergunta_id');

        foreach ($dadosResposta as $payload) {
            $row = $existing->get($payload['checklist_pergunta_id']);

            if ($row) {
                $row->update(Arr::except($payload, ['checklist_pergunta_id', 'tecnico_id']));

                continue;
            }

            $inspecao->respostas()->create($payload);
        }

        $outroProblema = (bool) $this->outro_problema;

        app(InspecaoService::class)->finalizar($inspecao, [
            'diagnostico' => $this->buildDiagnostico(),
            'observacoes' => null,
            'outro_problema' => $outroProblema,
            'descricao_outro_problema' => $outroProblema ? ($this->descricao_outro_problema ?: null) : null,
        ]);

        Notification::make()->success()->title('Inspeção finalizada')->send();

        $this->redirectRoute('filament.admin.resources.inspecaos.executar', ['record' => $inspecao->id]);
    }

    private function storeFoto(mixed $foto): ?string
    {
        if ($foto instanceof TemporaryUploadedFile) {
            return $foto->store('inspecoes/checklist', config('maintsys.upload_disk'));
        }

        return is_string($foto) ? $foto : null;
    }

    private function buildDiagnostico(): ?string
    {
        $itens = [];

        foreach ($this->perguntas as $pergunta) {
            $resposta = $this->respostas[$pergunta->id] ?? [];

            if (array_key_exists('conforme', $resposta)) {
                $itens[] = $pergunta->pergunta.': '.((bool) $resposta['conforme'] ? 'OK' : 'PROBLEMA');

                continue;
            }

            if (! empty($resposta['resposta'])) {
                $itens[] = $pergunta->pergunta.': '.$resposta['resposta'];
            }
        }

        return $itens === [] ? null : implode(' | ', $itens);
    }

    public function render()
    {
        return view('livewire.inspecao.executar-checklist-inspecao');
    }
}
