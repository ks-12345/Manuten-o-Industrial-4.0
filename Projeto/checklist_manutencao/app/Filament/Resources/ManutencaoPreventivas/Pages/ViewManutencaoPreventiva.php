<?php

namespace App\Filament\Resources\ManutencaoPreventivas\Pages;

use App\Filament\Resources\ManutencaoPreventivas\ManutencaoPreventivaResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewManutencaoPreventiva extends ViewRecord
{
    protected static string $resource = ManutencaoPreventivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
