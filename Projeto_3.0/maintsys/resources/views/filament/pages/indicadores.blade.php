<x-filament-panels::page>
    <div class="space-y-6">

        {{-- ── Filtros ─────────────────────────────────────────── --}}
        <x-filament::section>
            <x-slot name="heading">🔎 Filtros do Período</x-slot>

            <div class="flex flex-wrap items-end gap-4">
                {{-- Presets --}}
                <div class="flex flex-wrap gap-2">
                    @foreach(['semana' => 'Semana', 'mes' => 'Mês', 'trimestre' => 'Trimestre', 'semestre' => '6 Meses', 'ano' => 'Ano', 'custom' => 'Personalizado'] as $valor => $label)
                        <button wire:click="$set('periodoPreset', '{{ $valor }}')"
                                class="px-3 py-1.5 rounded-lg text-sm font-medium transition-colors
                                       {{ $periodoPreset === $valor ? 'bg-primary-600 text-white shadow' : 'bg-gray-100 hover:bg-gray-200 dark:bg-gray-700 dark:hover:bg-gray-600 text-gray-700 dark:text-gray-300' }}">
                            {{ $label }}
                        </button>
                    @endforeach
                </div>

                {{-- Datas customizadas --}}
                @if($periodoPreset === 'custom')
                    <div class="flex items-center gap-2">
                        <div>
                            <label class="block text-xs text-gray-500 mb-1">De</label>
                            <input wire:model="dataInicio" type="date"
                                   class="rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-3 py-1.5 text-sm"/>
                        </div>
                        <div>
                            <label class="block text-xs text-gray-500 mb-1">Até</label>
                            <input wire:model="dataFim" type="date"
                                   class="rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-3 py-1.5 text-sm"/>
                        </div>
                    </div>
                @endif

                <div class="flex gap-2">
                    <x-filament::button wire:click="aplicarFiltro" icon="heroicon-o-funnel" size="sm">
                        Aplicar
                    </x-filament::button>
                    <x-filament::button wire:click="exportarCSV" icon="heroicon-o-arrow-down-tray"
                                        color="success" size="sm">
                        Exportar CSV
                    </x-filament::button>
                </div>
            </div>

            <p class="mt-2 text-xs text-gray-400">
                Período: <strong>{{ $dataInicio }}</strong> → <strong>{{ $dataFim }}</strong>
            </p>
        </x-filament::section>

        @php $d = $this->dados; @endphp

        {{-- ── KPI Cards ───────────────────────────────────────── --}}
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            @php
                $kpis = [
                    ['label'=>'MTBF','valor'=>number_format($d['mtbf'],1).'h','sub'=>'Mean Time Between Failures','cor'=>'from-blue-500 to-blue-600','emoji'=>'⏱','meta'=>'Meta: ≥ 200h'],
                    ['label'=>'MTTR','valor'=>number_format($d['mttr'],1).'h','sub'=>'Mean Time To Repair','cor'=>'from-orange-500 to-orange-600','emoji'=>'🔧','meta'=>'Meta: ≤ 4h'],
                    ['label'=>'Disponibilidade','valor'=>number_format($d['disponibilidade'],1).'%','sub'=>'MTBF ÷ (MTBF + MTTR)','cor'=>$d['disponibilidade']>=95?'from-green-500 to-green-600':'from-red-500 to-red-600','emoji'=>'✅','meta'=>'Meta: ≥ 95%'],
                    ['label'=>'Custo Total','valor'=>'R$ '.number_format($d['resumo']['custo_total'],2,',','.'),'sub'=>$d['resumo']['total_corretivas'].' corretivas · '.$d['resumo']['total_preventivas'].' prev.','cor'=>'from-purple-500 to-purple-600','emoji'=>'💰','meta'=>''],
                ];
            @endphp

            @foreach($kpis as $kpi)
                <div class="rounded-xl bg-gradient-to-br {{ $kpi['cor'] }} p-4 text-white shadow-lg">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-xs font-semibold opacity-80">{{ $kpi['label'] }}</p>
                            <p class="text-3xl font-bold mt-1">{{ $kpi['valor'] }}</p>
                            <p class="text-xs opacity-70 mt-0.5">{{ $kpi['sub'] }}</p>
                        </div>
                        <span class="text-3xl">{{ $kpi['emoji'] }}</span>
                    </div>
                    @if($kpi['meta'])
                        <p class="text-xs opacity-60 mt-3">{{ $kpi['meta'] }}</p>
                    @endif
                </div>
            @endforeach
        </div>

        {{-- ── Falhas por Máquina ──────────────────────────────── --}}
        <x-filament::section>
            <x-slot name="heading">🏭 Indicadores por Máquina</x-slot>

            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead>
                        <tr class="border-b border-gray-200 dark:border-gray-700">
                            <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">#</th>
                            <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Máquina</th>
                            <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Patrimônio</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Falhas</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">MTBF (h)</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">MTTR (h)</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Disponib.</th>
                            <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Barra</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($d['por_maquina'] as $i => $row)
                            <tr class="border-b border-gray-100 dark:border-gray-800 hover:bg-gray-50 dark:hover:bg-gray-800/50">
                                <td class="py-2 px-3 text-gray-400 font-bold">{{ $i+1 }}</td>
                                <td class="py-2 px-3 font-medium text-gray-800 dark:text-white">{{ $row['maquina'] }}</td>
                                <td class="py-2 px-3 text-gray-500">{{ $row['patrimonio'] ?? '—' }}</td>
                                <td class="py-2 px-3 text-right">
                                    <span class="inline-flex items-center justify-center w-8 h-8 rounded-full
                                                 {{ $row['falhas'] > 5 ? 'bg-red-100 text-red-700' : 'bg-gray-100 text-gray-700' }}
                                                 font-bold text-sm">
                                        {{ $row['falhas'] }}
                                    </span>
                                </td>
                                <td class="py-2 px-3 text-right font-mono">{{ number_format($row['mtbf'],1) }}</td>
                                <td class="py-2 px-3 text-right font-mono">{{ number_format($row['mttr'],1) }}</td>
                                <td class="py-2 px-3 text-right">
                                    <span class="font-semibold {{ $row['disponib'] >= 95 ? 'text-green-600' : ($row['disponib'] >= 80 ? 'text-amber-600' : 'text-red-600') }}">
                                        {{ number_format($row['disponib'],1) }}%
                                    </span>
                                </td>
                                <td class="py-2 px-3 w-32">
                                    <div class="w-full bg-gray-100 dark:bg-gray-700 rounded-full h-2">
                                        <div class="h-2 rounded-full {{ $row['disponib'] >= 95 ? 'bg-green-500' : ($row['disponib'] >= 80 ? 'bg-amber-500' : 'bg-red-500') }}"
                                             style="width: {{ min(100, $row['disponib']) }}%"></div>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr><td colspan="8" class="text-center py-8 text-gray-400">Nenhum dado no período.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </x-filament::section>

        {{-- ── Falhas por Setor ────────────────────────────────── --}}
        <x-filament::section>
            <x-slot name="heading">🏢 Falhas por Setor</x-slot>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                @foreach($d['por_setor'] as $setor)
                    <div class="p-4 rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800">
                        <div class="flex items-start justify-between">
                            <div>
                                <p class="font-semibold text-gray-800 dark:text-white">{{ $setor['setor'] }}</p>
                                <p class="text-xs text-gray-400">{{ $setor['codigo'] }}</p>
                            </div>
                            <span class="text-2xl font-bold {{ $setor['falhas'] > 5 ? 'text-red-500' : 'text-gray-700 dark:text-gray-300' }}">
                                {{ $setor['falhas'] }}
                            </span>
                        </div>
                        <div class="mt-2 text-xs text-gray-500">falha(s) no período</div>
                    </div>
                @endforeach
            </div>
        </x-filament::section>

        {{-- ── Custos por Setor ────────────────────────────────── --}}
        <x-filament::section>
            <x-slot name="heading">💰 Custos por Setor</x-slot>
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead>
                        <tr class="border-b border-gray-200 dark:border-gray-700">
                            <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Setor</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Máquinas</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Corretivas (R$)</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400">Preventivas (R$)</th>
                            <th class="text-right py-2 px-3 font-semibold text-gray-600 dark:text-gray-400 text-lg">Total (R$)</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php $totalGeral = array_sum(array_column($d['custos_setor'], 'custo_total')); @endphp
                        @forelse($d['custos_setor'] as $row)
                            <tr class="border-b border-gray-100 dark:border-gray-800">
                                <td class="py-2 px-3 font-medium text-gray-800 dark:text-white">{{ $row['setor'] }}</td>
                                <td class="py-2 px-3 text-right text-gray-500">{{ $row['maquinas'] }}</td>
                                <td class="py-2 px-3 text-right text-red-600">
                                    R$ {{ number_format($row['custo_corretiva'], 2, ',', '.') }}
                                </td>
                                <td class="py-2 px-3 text-right text-green-600">
                                    R$ {{ number_format($row['custo_preventiva'], 2, ',', '.') }}
                                </td>
                                <td class="py-2 px-3 text-right font-bold text-gray-800 dark:text-white">
                                    R$ {{ number_format($row['custo_total'], 2, ',', '.') }}
                                    <div class="mt-1 w-full bg-gray-100 dark:bg-gray-700 rounded-full h-1.5">
                                        <div class="bg-purple-500 h-1.5 rounded-full"
                                             style="width: {{ $totalGeral > 0 ? ($row['custo_total']/$totalGeral*100) : 0 }}%"></div>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr><td colspan="5" class="text-center py-8 text-gray-400">Nenhum custo no período.</td></tr>
                        @endforelse
                        @if(!empty($d['custos_setor']))
                            <tr class="bg-gray-50 dark:bg-gray-900 font-bold">
                                <td class="py-2 px-3" colspan="2">TOTAL GERAL</td>
                                <td class="py-2 px-3 text-right text-red-600">
                                    R$ {{ number_format(array_sum(array_column($d['custos_setor'],'custo_corretiva')), 2, ',', '.') }}
                                </td>
                                <td class="py-2 px-3 text-right text-green-600">
                                    R$ {{ number_format(array_sum(array_column($d['custos_setor'],'custo_preventiva')), 2, ',', '.') }}
                                </td>
                                <td class="py-2 px-3 text-right text-purple-600">
                                    R$ {{ number_format($totalGeral, 2, ',', '.') }}
                                </td>
                            </tr>
                        @endif
                    </tbody>
                </table>
            </div>
        </x-filament::section>
    </div>
</x-filament-panels::page>