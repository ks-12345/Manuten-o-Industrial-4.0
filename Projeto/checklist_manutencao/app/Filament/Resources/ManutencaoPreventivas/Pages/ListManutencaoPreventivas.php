<?php

namespace App\Filament\Resources\ManutencaoPreventivas\Pages;

use App\Filament\Resources\ManutencaoPreventivas\ManutencaoPreventivaResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListManutencaoPreventivas extends ListRecords
{
    protected static string $resource = ManutencaoPreventivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
