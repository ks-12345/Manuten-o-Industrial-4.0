<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditInspecao extends EditRecord
{
    protected static string $resource = InspecaoResource::class;

    protected static string $view = 'filament.resources.inspecao-resource.pages.edit-inspecao';

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
