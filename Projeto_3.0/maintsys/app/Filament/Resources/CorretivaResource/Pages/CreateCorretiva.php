<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use App\Models\Maquina;
use App\Services\CorretivaService;
use App\DTOs\CorretivaDTO;
use App\Enums\TipoCorretiva;
use Filament\Resources\Pages\CreateRecord;

class CreateCorretiva extends CreateRecord
{
    protected static string $resource = CorretivaResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['status'] = 'em_andamento';
        $data['inicio'] = now();
        return $data;
    }

    protected function afterCreate(): void
    {
        // Atualizar status da máquina para manutenção
        Maquina::find($this->record->maquina_id)
               ?->update(['status' => \App\Enums\StatusMaquina::Manutencao->value]);
    }

    protected function getRedirectUrl(): string
    {
        return CorretivaResource::getUrl('executar', ['record' => $this->record]);
    }
}