<?php

namespace App\Filament\Resources\ManutencaoPreventivas\Pages;

use App\Filament\Resources\ManutencaoPreventivas\ManutencaoPreventivaResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditManutencaoPreventiva extends EditRecord
{
    protected static string $resource = ManutencaoPreventivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
