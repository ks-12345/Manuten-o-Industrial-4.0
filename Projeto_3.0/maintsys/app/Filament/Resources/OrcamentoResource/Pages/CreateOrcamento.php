<?php

namespace App\Filament\Resources\OrcamentoResource\Pages;

use App\Filament\Resources\OrcamentoResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateOrcamento extends CreateRecord
{
    protected static string $resource = OrcamentoResource::class;
    protected function mutateFormDataBeforeCreate(array $data): array
{
    $data['solicitacao_peca_id'] = request()->route('record');

    return $data;
}
}
