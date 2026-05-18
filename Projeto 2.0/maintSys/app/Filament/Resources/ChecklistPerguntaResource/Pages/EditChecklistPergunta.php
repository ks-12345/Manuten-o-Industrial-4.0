<?php

namespace App\Filament\Resources\ChecklistPerguntaResource\Pages;

use App\Filament\Resources\ChecklistPerguntaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditChecklistPergunta extends EditRecord
{
    protected static string $resource = ChecklistPerguntaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
