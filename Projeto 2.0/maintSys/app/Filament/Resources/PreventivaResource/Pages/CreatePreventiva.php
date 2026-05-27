<?php

namespace App\Filament\Resources\PreventivaResource\Pages;

use App\Filament\Resources\PreventivaResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreatePreventiva extends CreateRecord
{
    protected static string $resource = PreventivaResource::class;

    protected static string $view = 'filament.resources.preventiva-resource.pages.create-preventiva';
}
