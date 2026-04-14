<?php

namespace App\Filament\Resources\ManutencaoCorretivas\Pages;

use App\Filament\Resources\ManutencaoCorretivas\ManutencaoCorretivaResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListManutencaoCorretivas extends ListRecords
{
    protected static string $resource = ManutencaoCorretivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
