<x-filament-panels::page>
    <div class="space-y-4">
        {{-- Filtros por Setor --}}
        <div class="flex flex-wrap gap-2">
            <button wire:click="selecionarSetor(null)"
                class="px-3 py-1 rounded-full text-sm font-medium transition-colors
                       {{ is_null($setorSelecionado) ? 'bg-primary-600 text-white' : 'bg-gray-100 hover:bg-gray-200 dark:bg-gray-700 dark:hover:bg-gray-600' }}">
                Todos os Setores
            </button>
            @foreach($this->getSetores() as $setor)
                <button wire:click="selecionarSetor({{ $setor->id }})"
                    class="px-3 py-1 rounded-full text-sm font-medium transition-colors
                           {{ $setorSelecionado == $setor->id ? 'bg-primary-600 text-white' : 'bg-gray-100 hover:bg-gray-200 dark:bg-gray-700 dark:hover:bg-gray-600' }}">
                    {{ $setor->nome }}
                </button>
            @endforeach
        </div>

        {{-- Legenda --}}
        <div class="flex flex-wrap gap-4 p-3 bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
            @foreach($resumoStatus as $item)
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded-full" style="background-color: {{ $item['cor'] }}"></div>
                    <span class="text-sm text-gray-600 dark:text-gray-300">
                        {{ $item['label'] }} <span class="font-bold">({{ $item['total'] }})</span>
                    </span>
                </div>
            @endforeach
        </div>

        {{-- Mapa --}}
        <div class="relative bg-gray-50 dark:bg-gray-900 border-2 border-dashed border-gray-300 dark:border-gray-600 rounded-xl overflow-hidden"
             style="width: 100%; height: 600px;"
             id="mapa-container"
             x-data="mapaInterativo(@js($maquinas), @json(auth()->user()->hasRole('admin')))">

            {{-- Grid de fundo --}}
            <svg class="absolute inset-0 w-full h-full" style="opacity:0.05">
                <defs>
                    <pattern id="grid" width="50" height="50" patternUnits="userSpaceOnUse">
                        <path d="M 50 0 L 0 0 0 50" fill="none" stroke="currentColor" stroke-width="1"/>
                    </pattern>
                </defs>
                <rect width="100%" height="100%" fill="url(#grid)"/>
            </svg>

            {{-- Máquinas --}}
            <template x-for="maquina in maquinas" :key="maquina.id">
                <div
                    :id="'maquina-' + maquina.id"
                    class="absolute cursor-pointer select-none group"
                    :style="`left: ${maquina.posicao_x}px; top: ${maquina.posicao_y}px;`"
                    x-on:click="selecionarMaquina(maquina)"
                    :draggable="podeEditar"
                    x-on:dragstart="dragStart($event, maquina)"
                    x-on:dragend="dragEnd($event, maquina)"
                >
                    {{-- Ícone da máquina --}}
                    <div class="relative">
                        <div class="w-12 h-12 rounded-full border-4 border-white dark:border-gray-900 shadow-lg flex items-center justify-center transition-transform group-hover:scale-110"
                             :style="`background-color: ${maquina.cor}`">
                            <svg class="w-6 h-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                            </svg>
                        </div>

                        {{-- Badge de ocorrências abertas --}}
                        <div x-show="maquina.ocorrencias_abertas > 0"
                             class="absolute -top-1 -right-1 w-5 h-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center font-bold">
                            <span x-text="maquina.ocorrencias_abertas"></span>
                        </div>
                    </div>

                    {{-- Label da máquina --}}
                    <div class="mt-1 max-w-[100px] text-center">
                        <span class="text-xs font-medium text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 rounded px-1 py-0.5 shadow"
                              x-text="maquina.nome.substring(0, 15) + (maquina.nome.length > 15 ? '...' : '')"></span>
                    </div>
                </div>
            </template>
        </div>

        {{-- Painel de detalhes da máquina selecionada --}}
        @if ($maquinaSelecionada)
            <div class="p-4 bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <h3 class="text-lg font-bold text-gray-900 dark:text-white">
                            {{ $maquinaSelecionada['nome'] }}
                        </h3>
                        <p class="text-sm text-gray-500">{{ $maquinaSelecionada['setor'] }} · {{ $maquinaSelecionada['fabricante'] }} {{ $maquinaSelecionada['modelo'] }}</p>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-sm font-medium text-white"
                              style="background-color: {{ $maquinaSelecionada['cor'] }}">
                            {{ $maquinaSelecionada['status_label'] }}
                        </span>
                        <a href="{{ \App\Filament\Resources\MaquinaResource::getUrl('view', ['record' => $maquinaSelecionada['id']]) }}"
                           class="inline-flex items-center gap-1 px-3 py-1 rounded-lg bg-primary-600 text-white text-sm hover:bg-primary-700">
                            Ver Detalhes →
                        </a>
                    </div>
                </div>
                @if ($maquinaSelecionada['ocorrencias_abertas'] > 0)
                    <div class="mt-3 p-2 bg-red-50 dark:bg-red-900/20 rounded-lg border border-red-200">
                        <p class="text-sm text-red-700 dark:text-red-300 font-medium">
                            ⚠️ {{ $maquinaSelecionada['ocorrencias_abertas'] }} ocorrência(s) em aberto
                        </p>
                    </div>
                @endif
            </div>
        @endif
    </div>

    {{-- Script do mapa interativo --}}
    @push('scripts')
    <script>
    function mapaInterativo(maquinas, podeEditar) {
        return {
            maquinas: maquinas,
            podeEditar: podeEditar,
            dragging: null,
            dragOffsetX: 0,
            dragOffsetY: 0,

            selecionarMaquina(maquina) {
                this.$wire.selecionarMaquina(maquina.id);
            },

            dragStart(event, maquina) {
                if (!this.podeEditar) return;
                this.dragging = maquina;
                const rect = event.target.closest('div').getBoundingClientRect();
                this.dragOffsetX = event.clientX - rect.left;
                this.dragOffsetY = event.clientY - rect.top;
            },

            dragEnd(event, maquina) {
                if (!this.podeEditar || !this.dragging) return;
                const container = document.getElementById('mapa-container');
                const rect = container.getBoundingClientRect();
                const x = Math.max(0, event.clientX - rect.left - this.dragOffsetX);
                const y = Math.max(0, event.clientY - rect.top - this.dragOffsetY);

                maquina.posicao_x = x;
                maquina.posicao_y = y;

                this.$wire.dispatch('maquina-movida', {
                    maquinaId: maquina.id,
                    x: x,
                    y: y
                });

                this.dragging = null;
            }
        };
    }
    </script>
    @endpush
</x-filament-panels::page>