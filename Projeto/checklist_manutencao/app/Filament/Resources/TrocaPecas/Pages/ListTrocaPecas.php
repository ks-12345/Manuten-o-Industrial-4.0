<?php

namespace App\Filament\Resources\TrocaPecas\Pages;

use App\Filament\Resources\TrocaPecas\TrocaPecaResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListTrocaPecas extends ListRecords
{
    protected static string $resource = TrocaPecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
