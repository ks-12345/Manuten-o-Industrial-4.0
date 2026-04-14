<?php

namespace App\Filament\Resources\TrocaPecas\Pages;

use App\Filament\Resources\TrocaPecas\TrocaPecaResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewTrocaPeca extends ViewRecord
{
    protected static string $resource = TrocaPecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
