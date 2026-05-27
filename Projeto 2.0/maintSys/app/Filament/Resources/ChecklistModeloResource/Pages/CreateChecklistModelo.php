<?php

namespace App\Filament\Resources\ChecklistModeloResource\Pages;

use App\Filament\Resources\ChecklistModeloResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;


class CreateChecklistModelo extends CreateRecord
{
    protected static string $resource = ChecklistModeloResource::class;

    protected static string $view = 'filament.resources.checklist-modelo-resource.pages.create-checklist-modelo';
}
