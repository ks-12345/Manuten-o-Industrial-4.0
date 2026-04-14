<?php

namespace App\Filament\Resources\Localizacaos\Pages;

use App\Filament\Resources\Localizacaos\LocalizacaoResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListLocalizacaos extends ListRecords
{
    protected static string $resource = LocalizacaoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
