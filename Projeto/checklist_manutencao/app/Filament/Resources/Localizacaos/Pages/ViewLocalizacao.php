<?php

namespace App\Filament\Resources\Localizacaos\Pages;

use App\Filament\Resources\Localizacaos\LocalizacaoResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewLocalizacao extends ViewRecord
{
    protected static string $resource = LocalizacaoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
