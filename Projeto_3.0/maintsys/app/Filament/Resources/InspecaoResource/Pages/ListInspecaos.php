<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Illuminate\Support\Facades\Auth;

class ListInspecaos extends ListRecords
{
    protected static string $resource = InspecaoResource::class;

    protected function getHeaderActions(): array
    {
        // Inspeções não podem ser criadas manualmente.
        // Devem nascer apenas pelo fluxo: Ocorrência -> Executar Inspeção.
        return [];
    }

}
