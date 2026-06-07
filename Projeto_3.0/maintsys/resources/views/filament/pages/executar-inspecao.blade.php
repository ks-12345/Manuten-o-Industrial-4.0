<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Cabeçalho da Ocorrência --}}
        <x-filament::section>
            <x-slot name="heading">📋 Ocorrência: {{ $this->record->ocorrencia?->codigo }}</x-slot>
            <div class="grid grid-cols-3 gap-4 text-sm">
                <div>
                    <span class="text-gray-500">Máquina:</span>
                    <strong class="block">{{ $this->record->ocorrencia?->maquina?->nome }}</strong>
                </div>
                <div>
                    <span class="text-gray-500">Problema:</span>
                    <strong class="block">{{ $this->record->ocorrencia?->titulo }}</strong>
                </div>
                <div>
                    <span class="text-gray-500">Iniciada em:</span>
                    <strong class="block">{{ $this->record->inicio?->format('d/m/Y H:i') }}</strong>
                </div>
            </div>
        </x-filament::section>

        @if (!$finalizando)
            {{-- Checklist da Inspeção --}}
            <x-checklist-executor 
                :checklistModelo="$checklistInspecao"
                :respostasChecklist="$respostasChecklist"
                :modalPerguntaId="$modalPerguntaId"
                :mostrarModalNaoConforme="$mostrarModalNaoConforme" />

            {{-- Formulário de diagnóstico --}}
            <x-filament::section>
                <x-slot name="heading">🔍 Diagnóstico</x-slot>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium mb-1">Diagnóstico *</label>
                        <textarea wire:model="formData.diagnostico" rows="4"
                                  class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600"
                                  placeholder="Descreva o diagnóstico técnico..."></textarea>
                    </div>
                    <div>
                        <label class="block text-sm font-medium mb-1">Observações</label>
                        <textarea wire:model="formData.observacoes" rows="3"
                                  class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600"></textarea>
                    </div>
                </div>
            </x-filament::section>

            {{-- Pergunta obrigatória --}}
            <x-filament::section>
                <x-slot name="heading">⚠️ Necessita substituição de peça?</x-slot>
                <div class="flex gap-4">
                    <x-filament::button
                        wire:click="finalizarInspecao(['necessita_peca' => true])"
                        color="danger"
                        icon="heroicon-o-check"
                    >
                        ✅ Sim, necessita peça
                    </x-filament::button>
                    <x-filament::button
                        wire:click="finalizarInspecao(['necessita_peca' => false])"
                        color="success"
                        icon="heroicon-o-x-mark"
                    >
                        ❌ Não, pode prosseguir
                    </x-filament::button>
                </div>
            </x-filament::section>

        @else
            {{-- Confirmação de finalização --}}
            @if ($necessiPeca)
                <x-filament::section>
                    <x-slot name="heading">🔧 Solicitar Peça</x-slot>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium mb-1">Nome da Peça *</label>
                            <input wire:model="nomePeca" type="text"
                                   class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium mb-1">Quantidade *</label>
                            <input wire:model="quantidade" type="number" min="1"
                                   class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium mb-1">Referência</label>
                            <input wire:model="referenciaPeca" type="text"
                                   class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium mb-1">Descrição</label>
                            <textarea wire:model="descricaoPeca" rows="2"
                                      class="w-full rounded-lg border border-gray-300 p-3 dark:bg-gray-800 dark:border-gray-600"></textarea>
                        </div>
                    </div>
                </x-filament::section>
            @endif

            <div class="flex gap-3">
                <x-filament::button wire:click="salvarFinalizar" color="success" icon="heroicon-o-check">
                    Finalizar Inspeção
                </x-filament::button>
                <x-filament::button wire:click="$set('finalizando', false)" color="gray">
                    Voltar
                </x-filament::button>
            </div>
        @endif
    </div>
</x-filament-panels::page>