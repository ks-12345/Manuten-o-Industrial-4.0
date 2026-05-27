<?php

namespace App\Filament\Resources\MaquinaResource\Pages;

use App\Filament\Resources\MaquinaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditMaquina extends EditRecord
{
    protected static string $resource = MaquinaResource::class;

    protected static string $view = 'filament.resources.maquina-resource.pages.edit-maquina';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
