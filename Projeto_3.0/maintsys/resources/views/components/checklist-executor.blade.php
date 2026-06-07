<div>
    @if ($checklistModelo)
        <x-filament::section>
            <x-slot name="heading">✓ Checklist {{ $checklistModelo->tipo->getLabel() }}</x-slot>
            <x-slot name="description">Responda todas as perguntas do checklist. Não conformidades requerem evidência obrigatória.</x-slot>
            
            <div class="space-y-6">
                @foreach ($checklistModelo->perguntas as $pergunta)
                    <div class="border-l-4 border-primary-500 pl-4 py-2">
                        <p class="font-semibold text-gray-900 dark:text-gray-100 mb-3">
                            {{ $loop->iteration }}. {{ $pergunta->pergunta }}
                        </p>
                        
                        <div class="space-y-2">
                            {{-- Radio Buttons para Respostas --}}
                            <div class="flex gap-6 flex-wrap">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="radio" 
                                           name="resposta_{{ $pergunta->id }}"
                                           value="conforme"
                                           wire:change="selecionarResposta('{{ $pergunta->id }}', 'conforme')"
                                           @checked($respostasChecklist[$pergunta->id]['resposta'] === 'conforme')
                                           class="rounded">
                                    <span class="text-green-600 font-medium text-sm">✓ Conforme</span>
                                </label>
                                
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="radio" 
                                           name="resposta_{{ $pergunta->id }}"
                                           value="nao_conforme"
                                           wire:change="selecionarResposta('{{ $pergunta->id }}', 'nao_conforme')"
                                           @checked($respostasChecklist[$pergunta->id]['resposta'] === 'nao_conforme')
                                           class="rounded">
                                    <span class="text-red-600 font-medium text-sm">✗ Não Conforme</span>
                                </label>
                                
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="radio" 
                                           name="resposta_{{ $pergunta->id }}"
                                           value="nao_aplicavel"
                                           wire:change="selecionarResposta('{{ $pergunta->id }}', 'nao_aplicavel')"
                                           @checked($respostasChecklist[$pergunta->id]['resposta'] === 'nao_aplicavel')
                                           class="rounded">
                                    <span class="text-gray-600 font-medium text-sm">— N/A</span>
                                </label>
                            </div>

                            {{-- Exibir evidência se já foi preenchida --}}
                            @if ($respostasChecklist[$pergunta->id]['resposta'] === 'nao_conforme' && $respostasChecklist[$pergunta->id]['descricao'])
                                <div class="mt-3 p-3 bg-red-50 dark:bg-red-900/20 rounded-lg border border-red-200 dark:border-red-800">
                                    <p class="text-sm font-medium text-red-900 dark:text-red-100 mb-2">📷 Evidência Registrada</p>
                                    @if ($respostasChecklist[$pergunta->id]['evidencia'])
                                        <div class="mb-2">
                                            <a href="{{ $respostasChecklist[$pergunta->id]['evidencia'] }}" 
                                               target="_blank" 
                                               class="text-blue-600 hover:underline text-sm">
                                                Ver Imagem
                                            </a>
                                        </div>
                                    @endif
                                    <p class="text-sm text-gray-700 dark:text-gray-300">
                                        {{ $respostasChecklist[$pergunta->id]['descricao'] }}
                                    </p>
                                </div>
                            @endif
                        </div>
                    </div>
                @endforeach
            </div>
        </x-filament::section>
    @endif

    {{-- Modal de Não Conformidade --}}
    @if ($mostrarModalNaoConforme && $modalPerguntaId)
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
            <div class="bg-white dark:bg-gray-900 rounded-lg shadow-xl max-w-md w-full">
                <div class="p-6 border-b border-gray-200 dark:border-gray-700">
                    <h2 class="text-lg font-bold text-gray-900 dark:text-gray-100">📷 Registrar Não Conformidade</h2>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        Imagem e descrição são obrigatórias
                    </p>
                </div>

                <div class="p-6 space-y-4">
                    {{-- Upload de Imagem --}}
                    <div>
                        <label class="block text-sm font-medium text-gray-900 dark:text-gray-100 mb-2">
                            📸 Foto da Não Conformidade *
                        </label>
                        <input type="file" 
                               accept="image/*"
                               wire:model="respostasChecklist.{{ $modalPerguntaId }}.evidencia"
                               class="w-full rounded-lg border border-gray-300 dark:border-gray-600 px-3 py-2 text-sm">
                        @error("respostasChecklist.{$modalPerguntaId}.evidencia")
                            <p class="mt-1 text-xs text-red-600">{{ $message }}</p>
                        @enderror
                    </div>

                    {{-- Descrição --}}
                    <div>
                        <label class="block text-sm font-medium text-gray-900 dark:text-gray-100 mb-2">
                            📝 Descrição da Não Conformidade *
                        </label>
                        <textarea wire:model="respostasChecklist.{{ $modalPerguntaId }}.descricao"
                                  rows="4"
                                  placeholder="Descreva o problema encontrado..."
                                  class="w-full rounded-lg border border-gray-300 dark:border-gray-600 px-3 py-2 text-sm dark:bg-gray-800"></textarea>
                        @error("respostasChecklist.{$modalPerguntaId}.descricao")
                            <p class="mt-1 text-xs text-red-600">{{ $message }}</p>
                        @enderror
                    </div>
                </div>

                <div class="px-6 pb-6 flex gap-3 justify-end">
                    <button wire:click="fecharModal"
                            class="px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 text-sm font-medium">
                        Cancelar
                    </button>
                    <button wire:click="fecharModal"
                            class="px-4 py-2 rounded-lg bg-red-600 text-white hover:bg-red-700 text-sm font-medium">
                        Confirmar
                    </button>
                </div>
            </div>
        </div>
    @endif
</div>
