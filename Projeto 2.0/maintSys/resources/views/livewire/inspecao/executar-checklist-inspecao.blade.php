<div class="space-y-6">
    <div class="flex items-start justify-between gap-4">
        <div>
            <h2 class="text-lg font-semibold text-white">Executar Checklist - Inspeção</h2>
            <p class="text-sm text-gray-300">
                Máquina: <span class="font-medium">{{ $this->maquina->nome }}</span>
            </p>
        </div>
    </div>

    @if($this->checklistModelo)
        <div class="rounded-lg border border-white/10 bg-white/5 p-4">
            <div class="grid gap-4">
                @foreach($this->perguntas as $pergunta)
                    @php
                        $valor = $this->respostas[$pergunta->id] ?? [];
                        $tipo = $pergunta->tipo_resposta;
                    @endphp

                    <div class="rounded-lg border border-white/10 bg-black/20 p-4">
                        <div class="mb-3">
                            <p class="text-sm font-medium text-white">{{ $pergunta->pergunta }}</p>
                            @if($pergunta->obrigatorio)
                                <p class="text-xs text-amber-300">Obrigatório</p>
                            @endif
                        </div>

                        @if($tipo === \App\Enums\TipoResposta::Texto)
                            <x-filament::input.wrapper>
                                <x-filament::input
                                    wire:model.defer="respostas.{{ $pergunta->id }}.resposta"
                                    type="text"
                                    placeholder="Digite"
                                />
                            </x-filament::input.wrapper>
                        @elseif($tipo === \App\Enums\TipoResposta::Observacao)
                            <x-filament::input.wrapper>
                                <x-filament::input
                                    wire:model.defer="respostas.{{ $pergunta->id }}.observacao"
                                    type="text"
                                    placeholder="Observação"
                                />
                            </x-filament::input.wrapper>
                        @elseif($tipo === \App\Enums\TipoResposta::Foto)
                            <div class="space-y-2">
                                <input
                                    type="file"
                                    accept="image/*"
                                    wire:model="respostas.{{ $pergunta->id }}.foto"
                                    class="block w-full text-sm text-gray-200 file:mr-3 file:rounded-md file:border-0 file:bg-amber-500 file:px-3 file:py-2 file:text-sm file:font-semibold file:text-black"
                                />
                                @if(!empty($valor['foto']) && is_string($valor['foto']))
                                    <img
                                        src="{{ Storage::disk(config('maintsys.upload_disk'))->url($valor['foto']) }}"
                                        class="h-24 w-24 rounded border border-white/10 object-cover"
                                        alt="Foto registrada"
                                    />
                                @endif
                            </div>
                        @else
                            <div class="flex flex-wrap items-center gap-3">
                                <label class="flex items-center gap-2 text-sm text-white">
                                    <input
                                        type="radio"
                                        name="resp_{{ $pergunta->id }}"
                                        @checked(($valor['conforme'] ?? null) === true)
                                        wire:click="setResposta({{ $pergunta->id }}, true)"
                                    />
                                    OK
                                </label>
                                <label class="flex items-center gap-2 text-sm text-white">
                                    <input
                                        type="radio"
                                        name="resp_{{ $pergunta->id }}"
                                        @checked(($valor['conforme'] ?? null) === false)
                                        wire:click="setResposta({{ $pergunta->id }}, false)"
                                    />
                                    Problema
                                </label>
                            </div>
                        @endif

                        @if(!empty($pergunta->ajuda))
                            <p class="mt-2 text-xs text-gray-400">{{ $pergunta->ajuda }}</p>
                        @endif
                    </div>
                @endforeach
            </div>
        </div>

        <div class="space-y-4 rounded-lg border border-white/10 bg-white/5 p-4">
            <div>
                <h3 class="mb-2 text-sm font-semibold text-white">Diagnóstico - outro problema não previsto</h3>
                <label class="flex items-center gap-3 text-sm text-gray-100">
                    <input type="checkbox" wire:model.live="outro_problema" class="accent-amber-500" />
                    Marcar como outro problema
                </label>
            </div>

            @if($outro_problema)
                <x-filament::input.wrapper>
                    <x-filament::input
                        wire:model.defer="descricao_outro_problema"
                        type="text"
                        placeholder="Descreva o outro problema"
                    />
                </x-filament::input.wrapper>
            @endif

            <div class="flex justify-end">
                <x-filament::button wire:click="salvarChecklist" type="button" color="warning">
                    Finalizar inspeção
                </x-filament::button>
            </div>
        </div>
    @else
        <div class="rounded-lg border border-red-500/30 bg-red-500/10 p-4 text-red-200">
            Nenhum checklist ativo foi encontrado para esta máquina e tipo de inspeção.
        </div>
    @endif
</div>
