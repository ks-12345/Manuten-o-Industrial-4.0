<?php

namespace App\Filament\Resources\ChecklistPerguntaResource\Pages;

use App\Filament\Resources\ChecklistPerguntaResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateChecklistPergunta extends CreateRecord
{
    protected static string $resource = ChecklistPerguntaResource::class;

    protected static string $view = 'filament.resources.checklist-pergunta-resource.pages.create-checklist-pergunta';
}
