<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateCorretiva extends CreateRecord
{
    protected static string $resource = CorretivaResource::class;

    protected static string $view = 'filament.resources.corretiva-resource.pages.create-corretiva';
}
