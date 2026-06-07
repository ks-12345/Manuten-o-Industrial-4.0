<?php

namespace App\Filament\Resources\ChecklistModeloResource\Pages;

use App\Filament\Resources\ChecklistModeloResource;
use App\Services\ChecklistImportService;
use App\Services\ChecklistService;
use Filament\Actions;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\EditRecord;

class EditChecklistModelo extends EditRecord
{
    protected static string $resource = ChecklistModeloResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }

    protected function afterSave(): void
    {
        $arquivo = $this->data['arquivo_importacao'] ?? null;

        if (! $arquivo) {
            return;
        }

        $perguntas = app(ChecklistImportService::class)->perguntasFromStorage($arquivo, 'local');
        app(ChecklistService::class)->criarPerguntas($this->record, $perguntas);

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
