<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Enums\RespostaChecklist;
use App\Enums\TipoChecklist;
use App\Filament\Resources\CorretivaResource;
use App\Models\ChecklistModelo;
use App\Services\ChecklistService;
use App\Services\CorretivaService;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\Page;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use App\Models\Corretiva;

class ExecutarCorretiva extends Page implements HasForms
{
    use InteractsWithForms;

    protected static string $resource = CorretivaResource::class;
    protected static string $view     = 'filament.pages.executar-corretiva';

    public Corretiva $record;
    public string  $solucao       = '';
    public string  $resumo        = '';
    public float   $custoPecas    = 0;
    public float   $custoMaoObra  = 0;

    // Checklists
    public ?ChecklistModelo $checklistCorretiva = null;
    public array $respostasChecklist = [];
    public ?string $modalPerguntaId = null;
    public bool $mostrarModalNaoConforme = false;

    public function mount(Corretiva $record): void
    {
        $this->record      = $record;
        $this->solucao     = $record->solucao     ?? '';
        $this->resumo      = $record->resumo      ?? '';
        $this->custoPecas  = (float) ($record->custo_pecas    ?? 0);
        $this->custoMaoObra= (float) ($record->custo_mao_obra ?? 0);
        
        $this->carregarChecklist();
    }

    private function carregarChecklist(): void
    {
        $maquina = $this->record->maquina;
        if (!$maquina) return;

        $service = app(ChecklistService::class);
        $this->checklistCorretiva = $service->modeloParaMaquina($maquina, TipoChecklist::Corretiva);

        if ($this->checklistCorretiva) {
            $respostasExistentes = $this->record->checklistRespostas()
                ->with('pergunta')
                ->get()
                ->keyBy('checklist_pergunta_id');

            foreach ($this->checklistCorretiva->perguntas as $pergunta) {
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
            'solucao'        => $this->solucao,
            'resumo'         => $this->resumo,
            'custo_pecas'    => $this->custoPecas,
            'custo_mao_obra' => $this->custoMaoObra,
        ]);
        Notification::make()->info()->title('Rascunho salvo.')->send();
    }

    public function finalizar(): void
    {
        if ($this->checklistCorretiva) {
            $this->validarRespostasChecklist();
        }

        if ($this->checklistCorretiva) {
            app(ChecklistService::class)->salvarRespostas(
                $this->record,
                $this->checklistCorretiva,
                $this->respostasChecklist
            );
        }

        app(CorretivaService::class)->finalizar(
            $this->record,
            $this->solucao,
            $this->resumo,
            Auth::user(),
            $this->custoPecas,
            $this->custoMaoObra
        );

        Notification::make()->success()->title('Corretiva finalizada com sucesso!')->send();
        $this->redirect(CorretivaResource::getUrl('index'));
    }

    private function validarRespostasChecklist(): void
    {
        foreach ($this->checklistCorretiva->perguntas as $pergunta) {
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
        return "Executar Corretiva — {$this->record->maquina?->nome}";
    }
}