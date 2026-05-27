<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListCorretivas extends ListRecords
{
    protected static string $resource = CorretivaResource::class;

    protected static string $view = 'filament.resources.corretiva-resource.pages.list-corretivas';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
