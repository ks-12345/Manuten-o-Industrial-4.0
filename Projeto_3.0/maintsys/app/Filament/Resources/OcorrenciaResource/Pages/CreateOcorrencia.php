<?php

namespace App\Filament\Resources\OcorrenciaResource\Pages;

use App\Filament\Resources\OcorrenciaResource;
use App\Services\OcorrenciaService;
use App\DTOs\OcorrenciaDTO;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\Auth;

class CreateOcorrencia extends CreateRecord
{
    protected static string $resource = OcorrenciaResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['professor_id'] = Auth::id();
        return $data;
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('view', ['record' => $this->record]);
    }
}