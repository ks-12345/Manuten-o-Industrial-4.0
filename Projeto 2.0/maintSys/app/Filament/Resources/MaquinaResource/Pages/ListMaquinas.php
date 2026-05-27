<?php

namespace App\Filament\Resources\MaquinaResource\Pages;

use App\Filament\Resources\MaquinaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListMaquinas extends ListRecords
{
    protected static string $resource = MaquinaResource::class;

    protected static string $view = 'filament.resources.maquina-resource.pages.list-maquinas';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
