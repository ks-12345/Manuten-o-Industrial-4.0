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

use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Radio;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\Page;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use App\Models\Inspecao;

class ExecutarInspecao extends Page implements HasForms
{
    use InteractsWithForms;

    protected static string  $resource = InspecaoResource::class;
    protected static string  $view     = 'filament.pages.executar-inspecao';

    // public Model $record;
public Inspecao $record;

    // Dados do formulário
    public ?array $formData    = [];
    public bool   $finalizando = false;
    public bool   $necessiPeca = false;

    public function necessitaPeca(): void
    {
        $this->necessiPeca = true;
        $this->finalizando = true;
    }

    public function naoNecessitaPeca(): void
    {
        $this->necessiPeca = false;
        $this->finalizando = true;
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
        $this->carregarChecklist();
    }

    private function carregarChecklist(): void
    {
        $maquina = $this->record->ocorrencia?->maquina;
        if (!$maquina) return;

        $service = app(ChecklistService::class);
        $this->checklistInspecao = $service->modeloParaMaquina($maquina, TipoChecklist::Inspecao);

        if ($this->checklistInspecao) {
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

public function finalizarInspecao(array $data): void
{
    // Executa validações antes de entrar na etapa final de salvamento.
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
    // Revalida antes de salvar.
    if ($this->checklistInspecao) {
        $this->validarRespostasChecklist();
        app(ChecklistService::class)->salvarRespostas(
            $this->record,
            $this->checklistInspecao,
            $this->respostasChecklist
        );
    }

    $service = app(InspecaoService::class);

    $inspecao = $service->finalizar(
        $this->record,
        $this->formData['diagnostico']  ?? '',
        $this->necessiPeca,
        Auth::user(),
        $this->formData['observacoes'] ?? null
    );


        if ($this->necessiPeca && $this->nomePeca) {
            $service->solicitarPeca($inspecao, [
                'nome_peca'  => $this->nomePeca,
                'quantidade'  => $this->quantidade,
                'descricao'  => $this->descricaoPeca,
                'referencia' => $this->referenciaPeca,
            ]);
        }

        // Atualiza status da ocorrência com base no resultado da inspeção.
        app(OcorrenciaService::class)->finalizarAposInspecao(
            $inspecao->ocorrencia,
            $inspecao,
            Auth::user()
        );

        Notification::make()->success()->title('Inspeção finalizada com sucesso!')->send();

        return redirect()->to(InspecaoResource::getUrl('index'));
    }

    public function getTitle(): string
    {
        return "Inspeção — {$this->record->ocorrencia?->codigo}";
    }
}
