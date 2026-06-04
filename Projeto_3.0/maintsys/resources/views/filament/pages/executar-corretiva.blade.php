<x-filament-panels::page>
    <div class="space-y-6">
        <x-filament::section>
            <x-slot name="heading">🔧 {{ $this->record->maquina?->nome }}</x-slot>
            <div class="grid grid-cols-3 gap-4 text-sm">
                <div><span class="text-gray-500">Tipo:</span><strong class="block">{{ $this->record->tipo->getLabel() }}</strong></div>
                <div><span class="text-gray-500">Início:</span><strong class="block">{{ $this->record->inicio?->format('d/m/Y H:i') }}</strong></div>
                <div><span class="text-gray-500">Tempo decorrido:</span>
                    <strong class="block" x-data="{ minutos: 0 }" x-init="setInterval(() => minutos++, 60000)">
                        {{ $this->record->tempoDecorrido() }} min
                    </strong>
                </div>
            </div>
            <div class="mt-4 p-3 bg-amber-50 dark:bg-amber-900/20 rounded-lg border border-amber-200">
                <p class="text-sm font-medium text-amber-800 dark:text-amber-200">Problema:</p>
                <p class="text-sm">{{ $this->record->problema }}</p>
            </div>
        </x-filament::section>

        <x-filament::section>
            <x-slot name="heading">📝 Execução</x-slot>
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium mb-1">Solução Aplicada *</label>
                    <textarea wire:model="solucao" rows="4"
                              class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600"></textarea>
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Resumo Técnico</label>
                    <textarea wire:model="resumo" rows="3"
                              class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600"></textarea>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium mb-1">Custo de Peças (R$)</label>
                        <input wire:model="custoPecas" type="number" step="0.01"
                               class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium mb-1">Custo de Mão de Obra (R$)</label>
                        <input wire:model="custoMaoObra" type="number" step="0.01"
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
                Finalizar Corretiva
            </x-filament::button>
        </div>
    </div>
</x-filament-panels::page>