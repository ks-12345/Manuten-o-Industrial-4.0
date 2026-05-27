<?php

namespace App\Filament\Resources\PreventivaResource\Pages;

use App\Filament\Resources\PreventivaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditPreventiva extends EditRecord
{
    protected static string $resource = PreventivaResource::class;

    protected static string $view = 'filament.resources.preventiva-resource.pages.edit-preventiva';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
