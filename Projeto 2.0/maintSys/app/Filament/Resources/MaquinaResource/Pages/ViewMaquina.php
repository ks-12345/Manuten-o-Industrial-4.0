<?php

namespace App\Filament\Resources\MaquinaResource\Pages;

use App\Filament\Resources\MaquinaResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewMaquina extends ViewRecord
{
    protected static string $resource = MaquinaResource::class;

    protected static string $view = 'filament.resources.maquina-resource.pages.view-maquina';

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
        ];
    }
}
