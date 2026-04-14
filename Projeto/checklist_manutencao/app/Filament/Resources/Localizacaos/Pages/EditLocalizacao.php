<?php

namespace App\Filament\Resources\Localizacaos\Pages;

use App\Filament\Resources\Localizacaos\LocalizacaoResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditLocalizacao extends EditRecord
{
    protected static string $resource = LocalizacaoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
