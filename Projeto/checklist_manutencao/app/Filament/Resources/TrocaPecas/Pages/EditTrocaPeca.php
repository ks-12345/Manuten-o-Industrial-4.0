<?php

namespace App\Filament\Resources\TrocaPecas\Pages;

use App\Filament\Resources\TrocaPecas\TrocaPecaResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditTrocaPeca extends EditRecord
{
    protected static string $resource = TrocaPecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
