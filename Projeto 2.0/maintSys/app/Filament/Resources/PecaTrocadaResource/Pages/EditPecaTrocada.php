<?php

namespace App\Filament\Resources\PecaTrocadaResource\Pages;

use App\Filament\Resources\PecaTrocadaResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditPecaTrocada extends EditRecord
{
    protected static string $resource = PecaTrocadaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
