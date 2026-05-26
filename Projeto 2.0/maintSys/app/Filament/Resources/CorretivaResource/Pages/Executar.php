<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use Filament\Resources\Pages\Concerns\InteractsWithRecord;
use Filament\Resources\Pages\Page;

class Executar extends Page
{
    use InteractsWithRecord;

    protected static string $resource = CorretivaResource::class;

    protected static string $view = 'filament.resources.corretiva-resource.pages.executar';

    public function mount(int|string $record): void
    {
        $this->record = $this->resolveRecord($record);
    }

    public function getTitle(): string
    {
        return 'Executar corretiva';
    }
}
