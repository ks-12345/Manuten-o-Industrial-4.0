<?php

namespace App\Filament\Resources\ChecklistModeloResource\Pages;

use App\Filament\Resources\ChecklistModeloResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditChecklistModelo extends EditRecord
{
    protected static string $resource = ChecklistModeloResource::class;

    protected static string $view = 'filament.resources.checklist-modelo-resource.pages.edit-checklist-modelo';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
