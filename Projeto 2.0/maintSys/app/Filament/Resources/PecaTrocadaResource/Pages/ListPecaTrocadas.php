<?php

namespace App\Filament\Resources\PecaTrocadaResource\Pages;

use App\Filament\Resources\PecaTrocadaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPecaTrocadas extends ListRecords
{
    protected static string $resource = PecaTrocadaResource::class;

    protected static string $view = 'filament.resources.peca-trocada-resource.pages.list-peca-trocadas';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
