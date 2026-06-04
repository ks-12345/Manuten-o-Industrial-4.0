<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use App\Services\CorretivaService;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\Page;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class ExecutarCorretiva extends Page implements HasForms
{
    use InteractsWithForms;

    protected static string $resource = CorretivaResource::class;
    protected static string $view     = 'filament.pages.executar-corretiva';

    public Model $record;
    public string  $solucao       = '';
    public string  $resumo        = '';
    public float   $custoPecas    = 0;
    public float   $custoMaoObra  = 0;

    public function mount(Model $record): void
    {
        $this->record      = $record;
        $this->solucao     = $record->solucao     ?? '';
        $this->resumo      = $record->resumo      ?? '';
        $this->custoPecas  = (float) ($record->custo_pecas    ?? 0);
        $this->custoMaoObra= (float) ($record->custo_mao_obra ?? 0);
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

    public function getTitle(): string
    {
        return "Executar Corretiva — {$this->record->maquina?->nome}";
    }
}