<?php

namespace App\Filament\Resources\OcorrenciaResource\Pages;

use App\Enums\StatusOcorrencia;
use App\Filament\Resources\OcorrenciaResource;
use App\Services\InspecaoService;
use App\Services\OcorrenciaService;
use Filament\Actions;
use Filament\Forms\Components\Textarea;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ViewRecord;
use Illuminate\Support\Facades\Auth;

class ViewOcorrencia extends ViewRecord
{
    protected static string $resource = OcorrenciaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('assumir')
                ->label('Assumir Ocorrência')
                ->icon('heroicon-o-hand-raised')
                ->color('success')
                ->requiresConfirmation()
                ->visible(fn() => Auth::user()->can('assumir', $this->record))
                ->action(function () {
                    app(OcorrenciaService::class)->assumir($this->record, Auth::user());
                    $this->refreshFormData(['status', 'tecnico_id', 'assumida_em']);
                    Notification::make()->success()->title('Ocorrência assumida!')->send();
                }),

            Actions\Action::make('iniciar_inspecao')
                ->label('Iniciar Inspeção')
                ->icon('heroicon-o-magnifying-glass')
                ->color('info')
                ->visible(fn() => $this->record->tecnico_id === Auth::id()
                    && $this->record->status->value === 'em_analise'
                    && !$this->record->inspecao)
                ->action(function () {
                    app(InspecaoService::class)->iniciar($this->record, Auth::user());
                    $this->redirect(\App\Filament\Resources\InspecaoResource::getUrl('executar',
                        ['record' => $this->record->inspecao]));
                }),

            Actions\Action::make('cancelar')
                ->label('Cancelar')
                ->icon('heroicon-o-x-circle')
                ->color('danger')
                ->form([
                    Textarea::make('motivo')->label('Motivo')->required(),
                ])
                ->visible(fn() => Auth::user()->can('cancelar', $this->record))
                ->action(function (array $data) {
                    app(OcorrenciaService::class)->cancelar($this->record, Auth::user(), $data['motivo']);
                    $this->refreshFormData(['status']);
                    Notification::make()->success()->title('Ocorrência cancelada.')->send();
                }),
        ];
    }
}