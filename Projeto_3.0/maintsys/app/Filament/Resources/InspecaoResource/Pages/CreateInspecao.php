<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\Auth;

// Fluxo de criação manual removido.
// Esta classe permanece apenas para compatibilidade, mas o Resource não expõe a rota/ação.
// Mantemos o arquivo para evitar erro de autoload em referências antigas.

namespace App\Filament\Resources\InspecaoResource\Pages;

use Filament\Resources\Pages\Page;

class CreateInspecao extends Page
{
    protected static string $resource = \App\Filament\Resources\InspecaoResource::class;

    protected static string $view = 'filament.pages.inspecao-create-bloqueada';
}

