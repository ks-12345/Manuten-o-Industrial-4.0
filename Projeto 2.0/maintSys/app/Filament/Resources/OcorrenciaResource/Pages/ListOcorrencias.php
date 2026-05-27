<?php

namespace App\Filament\Resources\OcorrenciaResource\Pages;

use App\Filament\Resources\OcorrenciaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListOcorrencias extends ListRecords
{
    protected static string $resource = OcorrenciaResource::class;

    protected static string $view = 'filament.resources.ocorrencia-resource.pages.list-ocorrencias';

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
