<?php

namespace App\Filament\Resources\OrcamentoResource\Pages;
use App\Models\Orcamento;
use Illuminate\Validation\ValidationException;
use App\Filament\Resources\OrcamentoResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateOrcamento extends CreateRecord
{
    protected static string $resource = OrcamentoResource::class;

    
protected function beforeCreate(): void
{
    $quantidade = Orcamento::query()
        ->where('solicitacao_peca_id', $this->data['solicitacao_peca_id'])
        ->count();

    if ($quantidade >= 3) {
        throw ValidationException::withMessages([
            'solicitacao_peca_id' => 'Máximo de 3 orçamentos permitidos.',
        ]);
    }
}
}