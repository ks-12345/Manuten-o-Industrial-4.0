<?php

namespace App\Filament\Resources\SetorResource\Pages;

use App\Filament\Resources\SetorResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditSetor extends EditRecord
{
    protected static string $resource = SetorResource::class;

    protected static string $view = 'filament.resources.setor-resource.pages.edit-setor';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
