<?php

namespace App\Filament\Resources\Pecas\Pages;

use App\Filament\Resources\Pecas\PecaResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditPeca extends EditRecord
{
    protected static string $resource = PecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
