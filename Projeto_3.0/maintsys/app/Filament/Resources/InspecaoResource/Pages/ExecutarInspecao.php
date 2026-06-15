<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Enums\RespostaChecklist;
use App\Enums\TipoChecklist;
use App\Filament\Resources\InspecaoResource;
use App\Models\ChecklistModelo;
use App\Models\ChecklistResposta;
use App\Models\SolicitacaoPeca;
use App\Services\ChecklistService;
use App\Services\InspecaoService;
use App\Services\OcorrenciaService;
use Filament\Actions\Action;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\Page;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use App\Models\Inspecao;

class ExecutarInspecao extends Page
{
    protected static string $resource = InspecaoResource::class;
    protected static string $view     = 'filament.pages.executar-inspecao';

    public Inspecao $record;

    // Dados do formulário
    public ?array $formData    = [];
    public bool   $finalizando = false;
    public bool   $necessiPeca = false;
    
    // Força o estado inicial a ser nulo para exigir a seleção (Sim/Não)
    public ?bool  $necessitaCorretiva = null; 

    // Métodos acionados pelos botões da primeira etapa
    public function necessitaPeca(): void
    {
        $this->finalizarInspecao(['necessita_peca' => true]);
    }

    public function naoNecessitaPeca(): void
    {
        $this->finalizarInspecao(['necessita_peca' => false]);
    }

    // Dados da solicitação de peça
    public ?string $nomePeca   = null;
    public int     $quantidade = 1;
    public ?string $descricaoPeca  = null;
    public ?string $referenciaPeca = null;

    // Checklists
    public ?ChecklistModelo $checklistInspecao = null;
    public array $respostasChecklist = [];
    public ?string $modalPerguntaId = null;
    public bool $mostrarModalNaoConforme = false;

    public function mount(Inspecao $record): void
    {
        $this->record = $record;
        $this->formData = [
            'diagnostico' => $record->diagnostico ?? '',
            'observacoes' => $record->observacoes ?? '',
        ];
        $this->necessiPeca = (bool) $record->necessita_peca;

        if ($solicitacao = $record->solicitacaoPeca) {
            $this->nomePeca = $solicitacao->nome_peca;
            $this->quantidade = (int) $solicitacao->quantidade;
            $this->descricaoPeca = $solicitacao->descricao;
            $this->referenciaPeca = $solicitacao->referencia;
        }

        $this->carregarChecklist();
    }

    private function carregarChecklist(): void
    {
        $maquina = $this->record->ocorrencia?->maquina;

        if (!$maquina) {
            return;
        }

        $service = app(ChecklistService::class);

        $this->checklistInspecao = $service->modeloParaMaquina(
            $maquina,
            TipoChecklist::Inspecao
        );

        if (!$this->checklistInspecao) {
            Notification::make()
                ->warning()
                ->title('Checklist não encontrado')
                ->body("A máquina '{$maquina->nome}' não possui checklist de inspeção cadastrado.")
                ->persistent()
                ->send();

            return;
        }

        $respostasExistentes = $this->record->checklistRespostas()
            ->with('pergunta')
            ->get()
            ->keyBy('checklist_pergunta_id');

        foreach ($this->checklistInspecao->perguntas as $pergunta) {
            $resposta = $respostasExistentes->get($pergunta->id);

            $this->respostasChecklist[$pergunta->id] = [
                'resposta' => $resposta?->resposta_enum?->value ?? null,
                'evidencia' => $resposta?->evidencia ?? null,
                'descricao' => $resposta?->descricao ?? null,
            ];
        }

        if ($this->checklistInspecao->perguntas->isEmpty()) {
            Notification::make()
                ->warning()
                ->title('Checklist sem perguntas')
                ->body("O checklist '{$this->checklistInspecao->nome}' não possui perguntas cadastradas.")
                ->persistent()
                ->send();
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

        $modalPerguntaId = null;
    }

    public function finalizarInspecao(array $data): void
    {
        // Validação estrita da primeira etapa: impede o avanço se o diagnóstico estiver vazio
        $this->validate([
            'formData.diagnostico' => ['required', 'string', 'min:3'],
            'formData.observacoes' => ['nullable', 'string'],
        ], [
            'formData.diagnostico.required' => 'O campo Diagnóstico é obrigatório para avançar.',
            'formData.diagnostico.min' => 'O diagnóstico deve ter pelo menos 3 caracteres.',
        ]);

        if ($this->checklistInspecao) {
            $this->validarRespostasChecklist();
        }

        $this->finalizando = true;
        $this->necessiPeca = (bool) ($data['necessita_peca'] ?? false);
    }

    private function validarRespostasChecklist(): void
    {
        foreach ($this->checklistInspecao->perguntas as $pergunta) {
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
                        ->body("Pregunta '{$pergunta->pergunta}' requer evidência e descrição.")
                        ->send();

                    throw new \Exception('Não conformidade exige evidência e descrição.');
                }
            }
        }
    }

    public function salvarFinalizar()
    {
        // Validação completa de todos os campos antes do salvamento definitivo
        $this->validate([
            'formData.diagnostico' => ['required', 'string', 'min:3'],
            'formData.observacoes' => ['nullable', 'string'],
            
            // Exige obrigatoriamente a seleção (não pode continuar como null)
            'necessitaCorretiva'   => ['required', 'boolean'], 
            
            // Validações condicionais de peças
            'nomePeca'             => [$this->necessiPeca ? 'required' : 'nullable', 'string', 'max:255'],
            'quantidade'           => [$this->necessiPeca ? 'required' : 'nullable', 'integer', 'min:1'],
            'descricaoPeca'        => ['nullable', 'string'],
            'referenciaPeca'       => ['nullable', 'string', 'max:255'],
        ], [
            'formData.diagnostico.required' => 'Informe o diagnóstico antes de finalizar a inspeção.',
            'formData.diagnostico.min'      => 'O diagnóstico deve ter pelo menos 3 caracteres.',
            'necessitaCorretiva.required'   => 'Você deve responder se a máquina necessita ou não de manutenção corretiva.',
            'nomePeca.required'             => 'Informe o nome da peça necessária.',
            'quantidade.required'           => 'Informe a quantidade da peça.',
            'quantidade.min'                => 'A quantidade deve ser pelo menos 1.',
        ]);

        if ($this->checklistInspecao) {
            $this->validarRespostasChecklist();
            app(ChecklistService::class)->salvarRespostas(
                $this->record,
                $this->checklistInspecao,
                $this->respostasChecklist
            );
        }

        $service = app(InspecaoService::class);
        $inspecao = $this->record->fresh();

        if (!$inspecao->estaFinalizada()) {
            $inspecao = $service->finalizar(
                $inspecao,
                $this->formData['diagnostico']  ?? '',
                $this->necessiPeca,
                Auth::user(),
                $this->formData['observacoes'] ?? null,
                $this->necessitaCorretiva // Passagem correta do parâmetro booleano validado
            );
        }

        if ($this->necessiPeca && $this->nomePeca && !$inspecao->solicitacaoPeca()->exists()) {
            $service->solicitarPeca($inspecao, [
                'nome_peca'  => $this->nomePeca,
                'quantidade'  => $this->quantidade,
                'descricao'  => $this->descricaoPeca,
                'referencia' => $this->referenciaPeca,
            ]);
        }

        app(OcorrenciaService::class)->finalizarAposInspecao(
            $inspecao->ocorrencia,
            $inspecao,
            Auth::user()
        );

        Notification::make()
            ->success()
            ->title('Inspeção finalizada com sucesso!')
            ->send();

        $this->redirect(InspecaoResource::getUrl('index'));
    }

    public function getTitle(): string
    {
        return "Inspeção — {$this->record->ocorrencia?->codigo}";
    }
}