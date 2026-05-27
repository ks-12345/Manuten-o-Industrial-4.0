<?php

namespace App\Filament\Resources\OcorrenciaResource\Pages;

use App\Filament\Resources\OcorrenciaResource;
use App\Models\Maquina;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\Auth;

class CreateOcorrencia extends CreateRecord
{
    protected static string $resource = OcorrenciaResource::class;

    protected static string $view = 'filament.resources.ocorrencia-resource.pages.create-ocorrencia';

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        if (! empty($data['maquina_id'])) {
            $maquina = Maquina::find($data['maquina_id']);
            $data['setor_id'] = $maquina?->setor_id;
        }

        $data['aberto_por'] = Auth::id();

        return $data;
    }
}
