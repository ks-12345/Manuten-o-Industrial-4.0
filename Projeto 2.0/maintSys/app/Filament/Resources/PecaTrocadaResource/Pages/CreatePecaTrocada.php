<?php

namespace App\Filament\Resources\PecaTrocadaResource\Pages;

use App\Filament\Resources\PecaTrocadaResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreatePecaTrocada extends CreateRecord
{
    protected static string $resource = PecaTrocadaResource::class;

    protected static string $view = 'filament.resources.peca-trocada-resource.pages.create-peca-trocada';
}
