<?php

namespace App\Filament\Resources\Inspecaos\Pages;

use App\Filament\Resources\Inspecaos\InspecaoResource;
use App\Filament\Resources\Maquinas\MaquinaResource;
use Filament\Actions\Action;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListInspecaos extends ListRecords
{
    protected static string $resource = InspecaoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Action::make('verMaquinas')
                ->label('Ver máquinas cadastradas')
                ->icon('heroicon-o-cog-6-tooth')
                ->url(MaquinaResource::getUrl('index')),
            CreateAction::make(),
        ];
    }
}
