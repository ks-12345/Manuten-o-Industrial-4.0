<?php

namespace App\Filament\Resources\SolicitacaoPecaResource\Pages;

use App\Filament\Resources\SolicitacaoPecaResource;
use Filament\Resources\Pages\ListRecords;

class ListSolicitacaoPecas extends ListRecords
{
    protected static string $resource = SolicitacaoPecaResource::class;

    // Bug 5 corrigido: removido CreateAction — solicitações são criadas
    // apenas pelo fluxo de inspeção, não manualmente por aqui.
    protected function getHeaderActions(): array
    {
        return [];
    }
}