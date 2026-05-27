<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditCorretiva extends EditRecord
{
    protected static string $resource = CorretivaResource::class;

    protected static string $view = 'filament.resources.corretiva-resource.pages.edit-corretiva';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
