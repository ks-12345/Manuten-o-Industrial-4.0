<?php

namespace App\Filament\Resources\ChecklistModeloResource\Pages;

use App\Filament\Resources\ChecklistModeloResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListChecklistModelos extends ListRecords
{
    protected static string $resource = ChecklistModeloResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
