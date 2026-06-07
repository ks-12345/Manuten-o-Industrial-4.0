<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\Auth;

class CreateInspecao extends CreateRecord
{
    protected static string $resource = InspecaoResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['ocorrencia_id'] = request()->route('record'); // ou ownerRecord se vier de relação
        $data['tecnico_id'] = Auth::id();

        return $data;
    }
    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}