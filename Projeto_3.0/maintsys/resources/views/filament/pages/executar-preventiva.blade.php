<x-filament-panels::page>
    <div class="space-y-6">
        <x-filament::section>
            <x-slot name="heading">🔧 {{ $this->record->maquina?->nome }}</x-slot>
            <div class="grid grid-cols-3 gap-4 text-sm">
                <div>
                    <span class="text-gray-500">Data Prevista:</span>
                    <strong class="block">{{ $this->record->data_prevista?->format('d/m/Y') }}</strong>
                </div>
                <div>
                    <span class="text-gray-500">Periodicidade:</span>
                    <strong class="block">{{ $this->record->periodicidade->getLabel() }}</strong>
                </div>
                <div>
                    <span class="text-gray-500">Técnico:</span>
                    <strong class="block">{{ $this->record->tecnico?->name ?? 'Não atribuído' }}</strong>
                </div>
            </div>
        </x-filament::section>

        {{-- Checklist da Preventiva --}}
        <x-checklist-executor 
            :checklistModelo="$checklistPreventiva"
            :respostasChecklist="$respostasChecklist"
            :modalPerguntaId="$modalPerguntaId"
            :mostrarModalNaoConforme="$mostrarModalNaoConforme" />

        <x-filament::section>
            <x-slot name="heading">📝 Execução</x-slot>
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium mb-1">Observações</label>
                    <textarea wire:model="observacoes" rows="4"
                              class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600"></textarea>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium mb-1">Tempo de Execução (min)</label>
                        <input wire:model="tempoExecucao" type="number" min="0"
                               class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium mb-1">Custo (R$)</label>
                        <input wire:model="custo" type="number" step="0.01"
                               class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600" />
                    </div>
                </div>
            </div>
        </x-filament::section>

        <div class="flex gap-3">
            <x-filament::button wire:click="salvarRascunho" color="gray" icon="heroicon-o-document">
                Salvar Rascunho
            </x-filament::button>
            <x-filament::button wire:click="finalizar" color="success" icon="heroicon-o-check-circle">
                Finalizar Preventiva
            </x-filament::button>
        </div>
    </div>
</x-filament-panels::page>
