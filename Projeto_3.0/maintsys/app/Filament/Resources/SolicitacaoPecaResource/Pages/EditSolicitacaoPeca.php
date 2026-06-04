<?php

namespace App\Filament\Resources\SolicitacaoPecaResource\Pages;

use App\Filament\Resources\SolicitacaoPecaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditSolicitacaoPeca extends EditRecord
{
    protected static string $resource = SolicitacaoPecaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
            Actions\DeleteAction::make(),
        ];
    }
}
