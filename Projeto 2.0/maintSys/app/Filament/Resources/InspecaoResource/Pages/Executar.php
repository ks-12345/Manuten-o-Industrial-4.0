<?php

namespace App\Filament\Resources\InspecaoResource\Pages;

use App\Filament\Resources\InspecaoResource;
use Filament\Resources\Pages\Concerns\InteractsWithRecord;
use Filament\Resources\Pages\Page;

class Executar extends Page
{
    use InteractsWithRecord;

    protected static string $resource = InspecaoResource::class;

    protected static string $view = 'filament.resources.inspecao-resource.pages.executar';

    public function mount(int|string $record): void
    {
        $this->record = $this->resolveRecord($record);
    }

    public function getTitle(): string
    {
        return 'Executar inspeção';
    }
}
