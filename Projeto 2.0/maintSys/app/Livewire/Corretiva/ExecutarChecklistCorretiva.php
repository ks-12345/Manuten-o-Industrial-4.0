<?php

namespace App\Livewire\Corretiva;

use App\Enums\TipoChecklist;
use App\Enums\TipoResposta;
use App\Models\ChecklistModelo;
use App\Models\ChecklistPergunta;
use App\Models\ChecklistResposta;
use App\Models\Corretiva;
use App\Models\Maquina;
use App\Services\CorretivaService;
use Filament\Notifications\Notification;
use Illuminate\Support\Arr;
use Illuminate\Support\Collection;
use Livewire\Attributes\Computed;
use Livewire\Component;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;
use Livewire\WithFileUploads;

class ExecutarChecklistCorretiva extends Component
{
    use WithFileUploads;

    public string $corretivaId;

    public array $respostas = [];

    public ?string $solucao_aplicada = null;

    public ?string $resumo_tecnico = null;

    public ?string $observacoes = null;

    public ?int $tempo_reparo_minutos = null;

    public mixed $foto_depois = null;

    public array $pecas = [];

    public function mount(string $corretivaId): void
    {
        $this->corretivaId = $corretivaId;

        $corretiva = Corretiva::query()
            ->with(['respostas.pergunta', 'pecasTrocadas'])
            ->findOrFail($corretivaId);

        $this->solucao_aplicada = $corretiva->solucao_aplicada;
        $this->resumo_tecnico = $corretiva->resumo_tecnico;
        $this->observacoes = $corretiva->observacoes;
        $this->tempo_reparo_minutos = $corretiva->tempo_reparo_minutos;
        $this->foto_depois = $corretiva->foto_depois;

        $this->respostas = $corretiva->respostas
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

        $this->pecas = $corretiva->pecasTrocadas
            ->map(fn ($peca): array => [
                'id' => $peca->id,
                'nome_peca' => $peca->nome_peca,
                'codigo_peca' => $peca->codigo_peca,
                'quantidade' => $peca->quantidade,
                'motivo_troca' => $peca->motivo_troca,
                'observacoes' => $peca->observacoes,
            ])
            ->values()
            ->toArray();

        if ($this->pecas === []) {
            $this->adicionarPeca();
        }
    }

    #[Computed]
    public function corretiva(): Corretiva
    {
        return Corretiva::query()
            ->with(['ocorrencia', 'maquina', 'respostas.pergunta', 'pecasTrocadas'])
            ->findOrFail($this->corretivaId);
    }

    #[Computed]
    public function maquina(): Maquina
    {
        return $this->corretiva->maquina;
    }

    #[Computed]
    public function checklistModelo(): ?ChecklistModelo
    {
        return ChecklistModelo::query()
            ->where('ativo', true)
            ->where('tipo', TipoChecklist::Corretiva)
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

    public function adicionarPeca(): void
    {
        $this->pecas[] = [
            'nome_peca' => '',
            'codigo_peca' => '',
            'quantidade' => 1,
            'motivo_troca' => '',
            'observacoes' => '',
        ];
    }

    public function removerPeca(int $index): void
    {
        unset($this->pecas[$index]);

        $this->pecas = array_values($this->pecas);
    }

    public function salvarChecklist(): void
    {
        if (! $this->checklistModelo) {
            Notification::make()
                ->danger()
                ->title('Checklist não configurado')
                ->body('Nenhum checklist ativo encontrado para a máquina e tipo de corretiva.')
                ->send();

            return;
        }

        $corretiva = $this->corretiva;
        $this->persistirRespostas($corretiva);
        $this->persistirPecas($corretiva);

        $fotoDepois = $this->foto_depois instanceof TemporaryUploadedFile
            ? $this->foto_depois->store('corretivas/fotos', config('maintsys.upload_disk'))
            : (is_string($this->foto_depois) ? $this->foto_depois : null);

        app(CorretivaService::class)->finalizar($corretiva, [
            'solucao_aplicada' => $this->solucao_aplicada,
            'resumo_tecnico' => $this->resumo_tecnico,
            'observacoes' => $this->observacoes,
            'tempo_reparo_minutos' => $this->tempo_reparo_minutos,
            'foto_depois' => $fotoDepois,
        ]);

        Notification::make()->success()->title('Corretiva finalizada')->send();

        $this->redirectRoute('filament.admin.resources.corretivas.executar', ['record' => $corretiva->id]);
    }

    private function persistirRespostas(Corretiva $corretiva): void
    {
        $existing = $corretiva->respostas()->get()->keyBy('checklist_pergunta_id');

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

            $row = $existing->get($pergunta->id);

            if ($row) {
                $row->update(Arr::except($payload, ['checklist_pergunta_id', 'tecnico_id']));

                continue;
            }

            $corretiva->respostas()->create($payload);
        }
    }

    private function persistirPecas(Corretiva $corretiva): void
    {
        foreach ($this->pecas as $peca) {
            if (blank($peca['nome_peca'] ?? null)) {
                continue;
            }

            $corretiva->pecasTrocadas()->updateOrCreate(
                ['id' => $peca['id'] ?? null],
                [
                    'maquina_id' => $corretiva->maquina_id,
                    'tecnico_id' => auth()->id(),
                    'nome_peca' => $peca['nome_peca'],
                    'codigo_peca' => $peca['codigo_peca'] ?: null,
                    'quantidade' => max(1, (int) ($peca['quantidade'] ?? 1)),
                    'motivo_troca' => $peca['motivo_troca'] ?: 'Não informado',
                    'observacoes' => $peca['observacoes'] ?: null,
                    'data_troca' => now()->toDateString(),
                ],
            );
        }
    }

    private function storeFoto(mixed $foto): ?string
    {
        if ($foto instanceof TemporaryUploadedFile) {
            return $foto->store('corretivas/checklist', config('maintsys.upload_disk'));
        }

        return is_string($foto) ? $foto : null;
    }

    public function render()
    {
        return view('livewire.corretiva.executar-checklist-corretiva');
    }
}
