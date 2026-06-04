<?php

namespace App\Filament\Resources\MaquinaResource\Pages;

use App\Filament\Resources\MaquinaResource;
use App\Models\Corretiva;
use App\Filament\Resources\CorretivaResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;
use Illuminate\Support\Facades\Auth;

class ViewMaquina extends ViewRecord
{
    protected static string $resource = MaquinaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
            Actions\Action::make('nova_corretiva_direta')
                ->label('Corretiva Direta')
                ->icon('heroicon-o-wrench-screwdriver')
                ->color('warning')
                ->url(fn() => CorretivaResource::getUrl('create', [
                    'maquina_id' => $this->record->id,
                    'tipo'       => 'direta',
                ]))
                ->visible(fn() => Auth::user()->hasPermissionTo('corretivas.create')),
        ];
    }
}