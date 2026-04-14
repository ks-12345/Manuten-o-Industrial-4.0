<?php

namespace App\Filament\Resources\Pecas\Pages;

use App\Filament\Resources\Pecas\PecaResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewPeca extends ViewRecord
{
    protected static string $resource = PecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
