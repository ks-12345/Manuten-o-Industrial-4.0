<?php

namespace App\Filament\Resources\ChecklistPerguntaResource\Pages;

use App\Filament\Resources\ChecklistPerguntaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListChecklistPerguntas extends ListRecords
{
    protected static string $resource = ChecklistPerguntaResource::class;

    protected static string $view = 'filament.resources.checklist-pergunta-resource.pages.list-checklist-perguntas';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
