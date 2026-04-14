<?php

namespace App\Filament\Resources\Pecas\Pages;

use App\Filament\Resources\Pecas\PecaResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListPecas extends ListRecords
{
    protected static string $resource = PecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
