<?php

namespace App\Filament\Resources\PrevisaoFalhas\Pages;

use App\Filament\Resources\PrevisaoFalhas\PrevisaoFalhaResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListPrevisaoFalhas extends ListRecords
{
    protected static string $resource = PrevisaoFalhaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
