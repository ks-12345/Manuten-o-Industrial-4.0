<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Enums\TipoChecklist;
use App\Filament\Resources\InspecaoResource;
use App\Models\ChecklistModelo;
use App\Models\ChecklistResposta;
use App\Models\SolicitacaoPeca;
use App\Services\InspecaoService;
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

    // Dados da solicitação de peça
    public ?string $nomePeca   = null;
    public int     $quantidade = 1;
    public ?string $descricaoPeca  = null;
    public ?string $referenciaPeca = null;

    public function mount(Inspecao $record): void
    {
        $this->record = $record;
    }

    public function finalizarInspecao(array $data): void
    {
        $this->finalizando = true;
        $this->necessiPeca = $data['necessita_peca'];
    }

    public function salvarFinalizar(): void
    {
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
                'quantidade' => $this->quantidade,
                'descricao'  => $this->descricaoPeca,
                'referencia' => $this->referenciaPeca,
            ]);
        }

        Notification::make()->success()->title('Inspeção finalizada com sucesso!')->send();

        $this->redirect(InspecaoResource::getUrl('index'));
    }

    public function getTitle(): string
    {
        return "Inspeção — {$this->record->ocorrencia?->codigo}";
    }
}