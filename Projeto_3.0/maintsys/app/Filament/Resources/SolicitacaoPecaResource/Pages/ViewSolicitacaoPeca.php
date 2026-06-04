<?php

namespace App\Filament\Resources\SolicitacaoPecaResource\Pages;

use App\Filament\Resources\SolicitacaoPecaResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewSolicitacaoPeca extends ViewRecord
{
    protected static string $resource = SolicitacaoPecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }
}
