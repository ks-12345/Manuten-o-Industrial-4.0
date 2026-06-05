<x-filament-widgets::widget>
    <x-filament::section>
        <x-slot name="heading">
            <div class="flex items-center justify-between w-full">
                <span>📊 Indicadores de Confiabilidade</span>
                <div class="flex items-center gap-2">
                    <label class="text-sm text-gray-500">Período:</label>
                    <select wire:model.live="periodo"
                            class="text-sm rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-2 py-1">
                        <option value="mes">Este Mês</option>
                        <option value="trimestre">Este Trimestre</option>
                        <option value="semestre">Últimos 6 Meses</option>
                        <option value="ano">Este Ano</option>
                    </select>
                </div>
            </div>
        </x-slot>

        @php $i = $this->indicadores; @endphp

        {{-- KPI Cards --}}
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
            {{-- MTBF --}}
            <div class="rounded-xl bg-gradient-to-br from-blue-500 to-blue-600 p-4 text-white shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-blue-100">MTBF</p>
                        <p class="text-3xl font-bold mt-1">{{ number_format($i['mtbf'], 1) }}<span class="text-base font-normal ml-1">h</span></p>
                        <p class="text-xs text-blue-200 mt-1">Mean Time Between Failures</p>
                    </div>
                    <div class="text-4xl">⏱</div>
                </div>
                <div class="mt-3 text-xs text-blue-100">
                    Quanto maior, melhor
                </div>
            </div>

            {{-- MTTR --}}
            <div class="rounded-xl bg-gradient-to-br from-orange-500 to-orange-600 p-4 text-white shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-orange-100">MTTR</p>
                        <p class="text-3xl font-bold mt-1">{{ number_format($i['mttr'], 1) }}<span class="text-base font-normal ml-1">h</span></p>
                        <p class="text-xs text-orange-200 mt-1">Mean Time To Repair</p>
                    </div>
                    <div class="text-4xl">🔧</div>
                </div>
                <div class="mt-3 text-xs text-orange-100">
                    Quanto menor, melhor
                </div>
            </div>

            {{-- Disponibilidade --}}
            <div class="rounded-xl bg-gradient-to-br from-green-500 to-green-600 p-4 text-white shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-green-100">Disponibilidade</p>
                        <p class="text-3xl font-bold mt-1">{{ number_format($i['disponibilidade'], 1) }}<span class="text-base font-normal ml-1">%</span></p>
                        <p class="text-xs text-green-200 mt-1">MTBF / (MTBF + MTTR)</p>
                    </div>
                    <div class="text-4xl">✅</div>
                </div>
                {{-- Barra de progresso --}}
                <div class="mt-3">
                    <div class="w-full bg-green-700 rounded-full h-1.5">
                        <div class="bg-white h-1.5 rounded-full transition-all"
                             style="width: {{ min(100, $i['disponibilidade']) }}%"></div>
                    </div>
                    <p class="text-xs text-green-100 mt-1">Meta: ≥ 95%</p>
                </div>
            </div>

            {{-- Custo Total --}}
            <div class="rounded-xl bg-gradient-to-br from-purple-500 to-purple-600 p-4 text-white shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-purple-100">Custo de Manutenção</p>
                        <p class="text-2xl font-bold mt-1">R$ {{ number_format($i['custo_total'], 2, ',', '.') }}</p>
                        <p class="text-xs text-purple-200 mt-1">{{ $i['periodo']['inicio'] }} – {{ $i['periodo']['fim'] }}</p>
                    </div>
                    <div class="text-4xl">💰</div>
                </div>
                <div class="mt-3 text-xs text-purple-100">
                    {{ $i['total_corretivas'] }} corretivas · {{ $i['total_preventivas'] }} preventivas
                </div>
            </div>
        </div>

        {{-- Top 5 máquinas com mais falhas --}}
        @if(!empty($i['por_maquina']))
            <div>
                <h4 class="text-sm font-semibold text-gray-700 dark:text-gray-300 mb-3">
                    🏭 Top 5 Máquinas com Mais Falhas
                </h4>
                <div class="space-y-2">
                    @foreach($i['por_maquina'] as $index => $maquina)
                        @php
                            $maxFalhas = $i['por_maquina'][0]['falhas'];
                            $pct = $maxFalhas > 0 ? ($maquina['falhas'] / $maxFalhas * 100) : 0;
                            $cor = match(true) {
                                $index === 0 => 'bg-red-500',
                                $index === 1 => 'bg-orange-500',
                                $index === 2 => 'bg-amber-500',
                                default      => 'bg-blue-400',
                            };
                        @endphp
                        <div class="flex items-center gap-3">
                            <span class="text-xs text-gray-500 w-4 font-bold">{{ $index + 1 }}</span>
                            <div class="flex-1">
                                <div class="flex items-center justify-between mb-1">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">
                                        {{ $maquina['maquina'] }}
                                    </span>
                                    <div class="flex items-center gap-3 text-xs text-gray-500">
                                        <span class="font-bold text-gray-800 dark:text-white">{{ $maquina['falhas'] }} falhas</span>
                                        <span>MTBF: {{ number_format($maquina['mtbf'], 1) }}h</span>
                                        <span>MTTR: {{ number_format($maquina['mttr'], 1) }}h</span>
                                        <span class="{{ $maquina['disponib'] >= 95 ? 'text-green-600' : 'text-red-600' }} font-semibold">
                                            {{ number_format($maquina['disponib'], 1) }}%
                                        </span>
                                    </div>
                                </div>
                                <div class="w-full bg-gray-100 dark:bg-gray-700 rounded-full h-2">
                                    <div class="{{ $cor }} h-2 rounded-full transition-all duration-500"
                                         style="width: {{ $pct }}%"></div>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        @endif
    </x-filament::section>
</x-filament-widgets::widget>