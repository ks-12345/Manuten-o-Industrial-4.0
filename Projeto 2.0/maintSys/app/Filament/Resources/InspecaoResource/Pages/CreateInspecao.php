<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateInspecao extends CreateRecord
{
    protected static string $resource = InspecaoResource::class;

    protected static string $view = 'filament.resources.inspecao-resource.pages.create-inspecao';
}
