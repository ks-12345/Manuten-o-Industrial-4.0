<?php

namespace App\Filament\Resources\TipoMaquinaResource\Pages;

use App\Filament\Resources\TipoMaquinaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditTipoMaquina extends EditRecord
{
    protected static string $resource = TipoMaquinaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
