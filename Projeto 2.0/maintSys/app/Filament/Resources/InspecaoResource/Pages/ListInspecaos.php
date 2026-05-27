<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListInspecaos extends ListRecords
{
    protected static string $resource = InspecaoResource::class;

    protected static string $view = 'filament.resources.inspecao-resource.pages.list-inspecaos';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
