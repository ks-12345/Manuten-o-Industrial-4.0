<?php

namespace App\Filament\Resources\ChecklistModeloResource\Pages;

use App\Filament\Resources\ChecklistModeloResource;
use App\Services\ChecklistImportService;
use App\Services\ChecklistService;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;

class CreateChecklistModelo extends CreateRecord
{
    protected static string $resource = ChecklistModeloResource::class;

protected function afterCreate(): void
{
    $arquivo = $this->data['arquivo_importacao'] ?? null;

    if (is_array($arquivo)) {
        $arquivo = reset($arquivo);
    }

    if (! $arquivo) {
        return;
    }

    $perguntas = app(ChecklistImportService::class)
        ->perguntasFromStorage($arquivo, 'local');

    app(ChecklistService::class)
        ->criarPerguntas($this->record, $perguntas);

    Notification::make()
        ->success()
        ->title(count($perguntas) . ' pergunta(s) importada(s).')
        ->send();
}

protected function getRedirectUrl(): string
{
    return $this->getResource()::getUrl('index');
}

}
