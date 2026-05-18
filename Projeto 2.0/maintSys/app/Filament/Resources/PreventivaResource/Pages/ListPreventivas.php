<?php

namespace App\Filament\Resources\PreventivaResource\Pages;

use App\Filament\Resources\PreventivaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPreventivas extends ListRecords
{
    protected static string $resource = PreventivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
