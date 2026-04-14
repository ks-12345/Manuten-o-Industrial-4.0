<?php

namespace App\Filament\Resources\ManutencaoCorretivas\Pages;

use App\Filament\Resources\ManutencaoCorretivas\ManutencaoCorretivaResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewManutencaoCorretiva extends ViewRecord
{
    protected static string $resource = ManutencaoCorretivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
