<?php

namespace App\Filament\Resources\PrevisaoFalhas\Pages;

use App\Filament\Resources\PrevisaoFalhas\PrevisaoFalhaResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewPrevisaoFalha extends ViewRecord
{
    protected static string $resource = PrevisaoFalhaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
