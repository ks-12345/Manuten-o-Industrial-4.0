<?php

namespace App\Filament\Resources\Tecnicos\Pages;

use App\Filament\Resources\Tecnicos\TecnicoResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewTecnico extends ViewRecord
{
    protected static string $resource = TecnicoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
