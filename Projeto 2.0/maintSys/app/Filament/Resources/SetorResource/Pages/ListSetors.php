<?php

namespace App\Filament\Resources\SetorResource\Pages;

use App\Filament\Resources\SetorResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListSetors extends ListRecords
{
    protected static string $resource = SetorResource::class;

    protected static string $view = 'filament.resources.setor-resource.pages.list-setors';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
