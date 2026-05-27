<?php

namespace App\Filament\Resources\ChecklistPerguntaResource\Pages;

use App\Filament\Resources\ChecklistPerguntaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditChecklistPergunta extends EditRecord
{
    protected static string $resource = ChecklistPerguntaResource::class;

    protected static string $view = 'filament.resources.checklist-pergunta-resource.pages.edit-checklist-pergunta';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
