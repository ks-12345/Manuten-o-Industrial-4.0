<?php

namespace App\Filament\Resources\ManutencaoCorretivas\Pages;

use App\Filament\Resources\ManutencaoCorretivas\ManutencaoCorretivaResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditManutencaoCorretiva extends EditRecord
{
    protected static string $resource = ManutencaoCorretivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
