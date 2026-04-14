<?php

namespace App\Filament\Resources\PrevisaoFalhas\Pages;

use App\Filament\Resources\PrevisaoFalhas\PrevisaoFalhaResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditPrevisaoFalha extends EditRecord
{
    protected static string $resource = PrevisaoFalhaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
