<?php

namespace App\Filament\Resources\PreventivaResource\Pages;

use App\Enums\RespostaChecklist;
use App\Enums\TipoChecklist;
use App\Filament\Resources\PreventivaResource;
use App\Models\ChecklistModelo;
use App\Services\ChecklistService;
use App\Services\PreventivaService;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\Page;
use Illuminate\Support\Facades\Auth;
use App\Models\Preventiva;

class ExecutarPreventiva extends Page implements HasForms
{
    use InteractsWithForms;

    protected static string $resource = PreventivaResource::class;
    protected static string $view     = 'filament.pages.executar-preventiva';

    public Preventiva $record;
    public string  $observacoes   = '';
    public int     $tempoExecucao = 0;
    public float   $custo         = 0;

    // Checklists
    public ?ChecklistModelo $checklistPreventiva = null;
    public array $respostasChecklist = [];
    public ?string $modalPerguntaId = null;
    public bool $mostrarModalNaoConforme = false;

    public function mount(Preventiva $record): void
    {
        $this->record           = $record;
        $this->observacoes      = $record->observacoes ?? '';
        $this->tempoExecucao    = (int) ($record->tempo_execucao ?? 0);
        $this->custo            = (float) ($record->custo ?? 0);
        
        $this->carregarChecklist();
    }

    private function carregarChecklist(): void
    {
        $maquina = $this->record->maquina;
        if (!$maquina) return;

        $service = app(ChecklistService::class);
        $this->checklistPreventiva = $service->modeloParaMaquina($maquina, TipoChecklist::Preventiva);

        if ($this->checklistPreventiva) {
            $respostasExistentes = $this->record->checklistRespostas()
                ->with('pergunta')
                ->get()
                ->keyBy('checklist_pergunta_id');

            foreach ($this->checklistPreventiva->perguntas as $pergunta) {
                $resposta = $respostasExistentes->get($pergunta->id);
                $this->respostasChecklist[$pergunta->id] = [
                    'resposta' => $resposta?->resposta_enum?->value ?? null,
                    'evidencia' => $resposta?->evidencia ?? null,
                    'descricao' => $resposta?->descricao ?? null,
                ];
            }
        }
    }

    public function selecionarResposta(string $perguntaId, string $resposta): void
    {
        $this->respostasChecklist[$perguntaId]['resposta'] = $resposta;

        if ($resposta === RespostaChecklist::NaoConforme->value) {
            $this->modalPerguntaId = $perguntaId;
            $this->mostrarModalNaoConforme = true;
        } else {
            $this->respostasChecklist[$perguntaId]['evidencia'] = null;
            $this->respostasChecklist[$perguntaId]['descricao'] = null;
        }
    }

    public function fecharModal(): void
    {
        $this->mostrarModalNaoConforme = false;

        if (!$this->respostasChecklist[$this->modalPerguntaId]['evidencia'] ||
            !$this->respostasChecklist[$this->modalPerguntaId]['descricao']) {
            $this->respostasChecklist[$this->modalPerguntaId]['resposta'] = null;
        }

        $this->modalPerguntaId = null;
    }

    public function salvarRascunho(): void
    {
        $this->record->update([
            'observacoes'     => $this->observacoes,
            'tempo_execucao'  => $this->tempoExecucao,
            'custo'           => $this->custo,
        ]);
        Notification::make()->info()->title('Rascunho salvo.')->send();
    }

    public function finalizar(): void
    {
        if ($this->checklistPreventiva) {
            $this->validarRespostasChecklist();
        }

        if ($this->checklistPreventiva) {
            app(ChecklistService::class)->salvarRespostas(
                $this->record,
                $this->checklistPreventiva,
                $this->respostasChecklist
            );
        }

        app(PreventivaService::class)->finalizar(
            $this->record,
            Auth::user(),
            $this->observacoes ?? null,
            $this->custo,
            $this->tempoExecucao > 0 ? $this->tempoExecucao : null
        );

        Notification::make()->success()->title('Preventiva finalizada com sucesso!')->send();
        $this->redirect(PreventivaResource::getUrl('index'));
    }

    private function validarRespostasChecklist(): void
    {
        foreach ($this->checklistPreventiva->perguntas as $pergunta) {
            $resposta = $this->respostasChecklist[$pergunta->id]['resposta'] ?? null;

            if (!$resposta) {
                Notification::make()
                    ->warning()
                    ->title('Checklist Incompleto')
                    ->body("Pergunta: {$pergunta->pergunta}")
                    ->send();

                throw new \Exception('Todas as perguntas do checklist devem ser respondidas.');
            }

            if ($resposta === RespostaChecklist::NaoConforme->value) {
                $evidencia = $this->respostasChecklist[$pergunta->id]['evidencia'] ?? null;
                $descricao = $this->respostasChecklist[$pergunta->id]['descricao'] ?? null;

                if (!$evidencia || !$descricao) {
                    Notification::make()
                        ->warning()
                        ->title('Não Conformidade Incompleta')
                        ->body("Pergunta '{$pergunta->pergunta}' requer evidência e descrição.")
                        ->send();

                    throw new \Exception('Não conformidade exige evidência e descrição.');
                }
            }
        }
    }

    public function getTitle(): string
    {
        return "Executar Preventiva — {$this->record->maquina?->nome}";
    }
}
