<?php

namespace App\Filament\Resources\MaquinaResource\Pages;

use App\Enums\TipoChecklist;
use App\Filament\Resources\MaquinaResource;
use App\Services\ChecklistService;
use Filament\Resources\Pages\CreateRecord;

class CreateMaquina extends CreateRecord
{
    protected static string $resource = MaquinaResource::class;

    protected function afterCreate(): void
    {
        $tipos = [];

        if ($this->data['criar_checklist_inspecao'] ?? false) {
            $tipos[] = TipoChecklist::Inspecao->value;
        }

        if ($this->data['criar_checklist_corretiva'] ?? false) {
            $tipos[] = TipoChecklist::Corretiva->value;
        }

        if ($this->data['criar_checklist_preventiva'] ?? false) {
            $tipos[] = TipoChecklist::Preventiva->value;
        }

        app(ChecklistService::class)->criarChecklistsSelecionados($this->record, $tipos);
    }

    protected function getRedirectUrl(): string
{
    return $this->getResource()::getUrl('index');
}
}
