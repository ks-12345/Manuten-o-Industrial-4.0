<x-filament-panels::page>
<div class="space-y-6 text-gray-900 dark:text-gray-100">

    {{-- ── Filtros ──────────────────────────────────────────────────── --}}
    <div class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 shadow-sm overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex items-center gap-2">
            <x-heroicon-o-funnel class="w-4 h-4 text-gray-400" />
            <span class="text-sm font-semibold text-gray-600 dark:text-gray-300 uppercase tracking-wider">Período de Análise</span>
        </div>

        <div class="px-6 py-4 flex flex-wrap items-end gap-4">
            <div class="flex flex-wrap gap-2">
                @foreach(['semana' => 'Semana', 'mes' => 'Mês', 'trimestre' => 'Trimestre', 'semestre' => '6 Meses', 'ano' => 'Ano', 'custom' => 'Personalizado'] as $valor => $label)
                    <button
                        wire:click="$set('periodoPreset', '{{ $valor }}')"
                        class="px-4 py-1.5 rounded-full text-sm font-medium transition-all duration-150
                        {{ $periodoPreset === $valor
                            ? 'bg-primary-600 text-white shadow-md shadow-primary-200 dark:shadow-none'
                            : 'bg-gray-100 hover:bg-gray-200 text-gray-600 dark:bg-gray-800 dark:hover:bg-gray-700 dark:text-gray-300' }}"
                    >{{ $label }}</button>
                @endforeach
            </div>

            @if($periodoPreset === 'custom')
                <div class="flex items-center gap-3">
                    <div>
                        <label class="block text-xs text-gray-400 mb-1 font-medium">De</label>
                        <input wire:model="dataInicio" type="date"
                            class="rounded-lg border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-gray-100 px-3 py-1.5 text-sm focus:ring-2 focus:ring-primary-500 outline-none" />
                    </div>
                    <div class="mt-4 text-gray-300">→</div>
                    <div>
                        <label class="block text-xs text-gray-400 mb-1 font-medium">Até</label>
                        <input wire:model="dataFim" type="date"
                            class="rounded-lg border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-gray-100 px-3 py-1.5 text-sm focus:ring-2 focus:ring-primary-500 outline-none" />
                    </div>
                </div>
            @endif

            <div class="flex gap-2 ml-auto">
                <x-filament::button wire:click="aplicarFiltro" icon="heroicon-o-funnel" size="sm">
                    Aplicar
                </x-filament::button>
                <x-filament::button wire:click="exportarCSV" icon="heroicon-o-arrow-down-tray" color="success" size="sm">
                    Exportar CSV
                </x-filament::button>
            </div>
        </div>

        <div class="px-6 pb-3">
            <p class="text-xs text-gray-400 dark:text-gray-500">
                Exibindo dados de
                <span class="font-semibold text-gray-600 dark:text-gray-300">{{ \Carbon\Carbon::parse($dataInicio)->format('d/m/Y') }}</span>
                até
                <span class="font-semibold text-gray-600 dark:text-gray-300">{{ \Carbon\Carbon::parse($dataFim)->format('d/m/Y') }}</span>
            </p>
        </div>
    </div>

    @php $d = $this->dados; @endphp

    {{-- ── KPI Cards ────────────────────────────────────────────────── --}}
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">

        {{-- MTBF --}}
        <div class="rounded-2xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 shadow-sm p-5 flex flex-col gap-3">
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-widest text-blue-500">MTBF</span>
                <div class="w-8 h-8 rounded-lg bg-blue-50 dark:bg-blue-900/30 flex items-center justify-center">
                    <x-heroicon-o-clock class="w-4 h-4 text-blue-500" />
                </div>
            </div>
            <div>
                <p class="text-4xl font-black text-gray-900 dark:text-white tracking-tight">
                    {{ number_format($d['mtbf'], 1) }}<span class="text-lg font-medium text-gray-400 ml-1">h</span>
                </p>
                <p class="text-xs text-gray-400 mt-1">Mean Time Between Failures</p>
            </div>
            <div class="pt-2 border-t border-gray-100 dark:border-gray-800">
                <span class="text-xs {{ $d['mtbf'] >= 200 ? 'text-green-500' : 'text-amber-500' }} font-semibold">
                    {{ $d['mtbf'] >= 200 ? '✓ Meta atingida' : '↗ Meta: ≥ 200h' }}
                </span>
            </div>
        </div>

        {{-- MTTR --}}
        <div class="rounded-2xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 shadow-sm p-5 flex flex-col gap-3">
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-widest text-orange-500">MTTR</span>
                <div class="w-8 h-8 rounded-lg bg-orange-50 dark:bg-orange-900/30 flex items-center justify-center">
                    <x-heroicon-o-wrench-screwdriver class="w-4 h-4 text-orange-500" />
                </div>
            </div>
            <div>
                <p class="text-4xl font-black text-gray-900 dark:text-white tracking-tight">
                    {{ number_format($d['mttr'], 1) }}<span class="text-lg font-medium text-gray-400 ml-1">h</span>
                </p>
                <p class="text-xs text-gray-400 mt-1">Mean Time To Repair</p>
            </div>
            <div class="pt-2 border-t border-gray-100 dark:border-gray-800">
                <span class="text-xs {{ $d['mttr'] <= 4 ? 'text-green-500' : 'text-red-500' }} font-semibold">
                    {{ $d['mttr'] <= 4 ? '✓ Meta atingida' : '↘ Meta: ≤ 4h' }}
                </span>
            </div>
        </div>

        {{-- Disponibilidade --}}
        @php $disp = $d['disponibilidade']; @endphp
        <div class="rounded-2xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 shadow-sm p-5 flex flex-col gap-3">
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-widest {{ $disp >= 95 ? 'text-green-500' : 'text-red-500' }}">Disponibilidade</span>
                <div class="w-8 h-8 rounded-lg {{ $disp >= 95 ? 'bg-green-50 dark:bg-green-900/30' : 'bg-red-50 dark:bg-red-900/30' }} flex items-center justify-center">
                    <x-heroicon-o-check-circle class="w-4 h-4 {{ $disp >= 95 ? 'text-green-500' : 'text-red-500' }}" />
                </div>
            </div>
            <div>
                <p class="text-4xl font-black tracking-tight {{ $disp >= 95 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400' }}">
                    {{ number_format($disp, 1) }}<span class="text-lg font-medium ml-1">%</span>
                </p>
                <p class="text-xs text-gray-400 mt-1">MTBF ÷ (MTBF + MTTR)</p>
            </div>
            <div class="pt-2 border-t border-gray-100 dark:border-gray-800">
                <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-1.5">
                    <div class="h-1.5 rounded-full {{ $disp >= 95 ? 'bg-green-500' : ($disp >= 80 ? 'bg-amber-500' : 'bg-red-500') }}"
                        style="width: {{ min(100, $disp) }}%"></div>
                </div>
                <span class="text-xs {{ $disp >= 95 ? 'text-green-500' : 'text-red-500' }} font-semibold mt-1 block">
                    {{ $disp >= 95 ? '✓ Meta atingida' : '↘ Meta: ≥ 95%' }}
                </span>
            </div>
        </div>

        {{-- Custo --}}
        <div class="rounded-2xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 shadow-sm p-5 flex flex-col gap-3">
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-widest text-purple-500">Custo Total</span>
                <div class="w-8 h-8 rounded-lg bg-purple-50 dark:bg-purple-900/30 flex items-center justify-center">
                    <x-heroicon-o-currency-dollar class="w-4 h-4 text-purple-500" />
                </div>
            </div>
            <div>
                <p class="text-2xl font-black text-gray-900 dark:text-white tracking-tight">
                    R$ {{ number_format($d['resumo']['custo_total'], 2, ',', '.') }}
                </p>
                <p class="text-xs text-gray-400 mt-1">no período selecionado</p>
            </div>
            <div class="pt-2 border-t border-gray-100 dark:border-gray-800 flex gap-3 text-xs text-gray-500">
                <span>🔧 {{ $d['resumo']['total_corretivas'] }} corretivas</span>
                <span>📋 {{ $d['resumo']['total_preventivas'] }} prev.</span>
            </div>
        </div>

    </div>

    {{-- ── Indicadores por Máquina ──────────────────────────────────── --}}
    <div class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 shadow-sm overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex items-center gap-2">
            <x-heroicon-o-cpu-chip class="w-4 h-4 text-gray-400" />
            <span class="text-sm font-semibold text-gray-600 dark:text-gray-300 uppercase tracking-wider">Indicadores por Máquina</span>
            <span class="ml-auto text-xs text-gray-400">{{ count($d['por_maquina']) }} máquinas</span>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead>
                    <tr class="bg-gray-50 dark:bg-gray-800/50">
                        <th class="text-left py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">#</th>
                        <th class="text-left py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">Máquina</th>
                        <th class="text-left py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">Patrimônio</th>
                        <th class="text-right py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">Falhas</th>
                        <th class="text-right py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">MTBF</th>
                        <th class="text-right py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">MTTR</th>
                        <th class="text-right py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">Disponib.</th>
                        <th class="py-3 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider w-36">Barra</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                    @forelse($d['por_maquina'] as $i => $row)
                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                            <td class="py-3 px-4 text-xs font-bold text-gray-300 dark:text-gray-600">{{ str_pad($i + 1, 2, '0', STR_PAD_LEFT) }}</td>
                            <td class="py-3 px-4">
                                <span class="font-semibold text-gray-800 dark:text-gray-100">{{ $row['maquina'] }}</span>
                            </td>
                            <td class="py-3 px-4 text-gray-400 font-mono text-xs">{{ $row['patrimonio'] ?? '—' }}</td>
                            <td class="py-3 px-4 text-right">
                                <span class="inline-flex items-center justify-center min-w-[2rem] h-6 px-2 rounded-full text-xs font-bold
                                    {{ $row['falhas'] > 5
                                        ? 'bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-300'
                                        : 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-300' }}">
                                    {{ $row['falhas'] }}
                                </span>
                            </td>
                            <td class="py-3 px-4 text-right font-mono text-gray-700 dark:text-gray-200">{{ number_format($row['mtbf'], 1) }}h</td>
                            <td class="py-3 px-4 text-right font-mono text-gray-700 dark:text-gray-200">{{ number_format($row['mttr'], 1) }}h</td>
                            <td class="py-3 px-4 text-right">
                                <span class="font-bold text-sm
                                    {{ $row['disponib'] >= 95 ? 'text-green-600 dark:text-green-400'
                                        : ($row['disponib'] >= 80 ? 'text-amber-500 dark:text-amber-400'
                                        : 'text-red-600 dark:text-red-400') }}">
                                    {{ number_format($row['disponib'], 1) }}%
                                </span>
                            </td>
                            <td class="py-3 px-4">
                                <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-2">
                                    <div class="h-2 rounded-full transition-all
                                        {{ $row['disponib'] >= 95 ? 'bg-green-500' : ($row['disponib'] >= 80 ? 'bg-amber-500' : 'bg-red-500') }}"
                                        style="width: {{ min(100, $row['disponib']) }}%">
                                    </div>
                                </div>
                                <span class="text-xs text-gray-400 mt-0.5 block">{{ number_format(min(100, $row['disponib']), 0) }}%</span>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="8" class="text-center py-12 text-gray-400">
                                <x-heroicon-o-circle-stack class="w-8 h-8 mx-auto mb-2 opacity-30" />
                                Nenhum dado no período.
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>

    {{-- ── Falhas por Setor + Custos por Setor (lado a lado) ─────────── --}}
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">

        {{-- Falhas por Setor --}}
        <div class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex items-center gap-2">
                <x-heroicon-o-building-office-2 class="w-4 h-4 text-gray-400" />
                <span class="text-sm font-semibold text-gray-600 dark:text-gray-300 uppercase tracking-wider">Falhas por Setor</span>
            </div>
            <div class="p-4 space-y-3">
                @forelse($d['por_setor'] as $setor)
                    @php $maxFalhas = max(array_column($d['por_setor'], 'falhas') ?: [1]); @endphp
                    <div class="flex items-center gap-3">
                        <div class="w-32 shrink-0">
                            <p class="font-semibold text-sm text-gray-800 dark:text-gray-100 truncate">{{ $setor['setor'] }}</p>
                            <p class="text-xs text-gray-400">{{ $setor['codigo'] ?? '' }}</p>
                        </div>
                        <div class="flex-1 bg-gray-100 dark:bg-gray-800 rounded-full h-3">
                            <div class="h-3 rounded-full {{ $setor['falhas'] > 5 ? 'bg-red-500' : 'bg-blue-400' }} transition-all"
                                style="width: {{ $maxFalhas > 0 ? ($setor['falhas'] / $maxFalhas * 100) : 0 }}%">
                            </div>
                        </div>
                        <span class="w-8 text-right font-bold text-sm {{ $setor['falhas'] > 5 ? 'text-red-500' : 'text-gray-600 dark:text-gray-300' }}">
                            {{ $setor['falhas'] }}
                        </span>
                    </div>
                @empty
                    <p class="text-center text-sm text-gray-400 py-6">Nenhum dado no período.</p>
                @endforelse
            </div>
        </div>

        {{-- Custos por Setor --}}
        <div class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex items-center gap-2">
                <x-heroicon-o-banknotes class="w-4 h-4 text-gray-400" />
                <span class="text-sm font-semibold text-gray-600 dark:text-gray-300 uppercase tracking-wider">Custos por Setor</span>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead>
                        <tr class="bg-gray-50 dark:bg-gray-800/50">
                            <th class="text-left py-2 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">Setor</th>
                            <th class="text-right py-2 px-4 text-xs font-semibold text-red-400 uppercase tracking-wider">Corretiva</th>
                            <th class="text-right py-2 px-4 text-xs font-semibold text-green-500 uppercase tracking-wider">Preventiva</th>
                            <th class="text-right py-2 px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider">Total</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                        @php $totalGeral = array_sum(array_column($d['custos_setor'], 'custo_total')); @endphp
                        @forelse($d['custos_setor'] as $row)
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                <td class="py-2.5 px-4">
                                    <p class="font-semibold text-gray-800 dark:text-gray-100 text-xs">{{ $row['setor'] }}</p>
                                    <div class="mt-1 w-full bg-gray-100 dark:bg-gray-800 rounded-full h-1">
                                        <div class="bg-purple-400 h-1 rounded-full"
                                            style="width: {{ $totalGeral > 0 ? ($row['custo_total'] / $totalGeral * 100) : 0 }}%"></div>
                                    </div>
                                </td>
                                <td class="py-2.5 px-4 text-right text-xs text-red-500 font-mono">R$ {{ number_format($row['custo_corretiva'], 2, ',', '.') }}</td>
                                <td class="py-2.5 px-4 text-right text-xs text-green-500 font-mono">R$ {{ number_format($row['custo_preventiva'], 2, ',', '.') }}</td>
                                <td class="py-2.5 px-4 text-right text-xs font-bold text-gray-800 dark:text-gray-100 font-mono">R$ {{ number_format($row['custo_total'], 2, ',', '.') }}</td>
                            </tr>
                        @empty
                            <tr><td colspan="4" class="text-center py-6 text-gray-400 text-xs">Nenhum custo no período.</td></tr>
                        @endforelse
                        @if(!empty($d['custos_setor']))
                            <tr class="bg-gray-50 dark:bg-gray-800/60">
                                <td class="py-2.5 px-4 text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Total Geral</td>
                                <td class="py-2.5 px-4 text-right text-xs font-bold text-red-500 font-mono">R$ {{ number_format(array_sum(array_column($d['custos_setor'], 'custo_corretiva')), 2, ',', '.') }}</td>
                                <td class="py-2.5 px-4 text-right text-xs font-bold text-green-500 font-mono">R$ {{ number_format(array_sum(array_column($d['custos_setor'], 'custo_preventiva')), 2, ',', '.') }}</td>
                                <td class="py-2.5 px-4 text-right text-xs font-bold text-purple-600 dark:text-purple-400 font-mono">R$ {{ number_format($totalGeral, 2, ',', '.') }}</td>
                            </tr>
                        @endif
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</div>
</x-filament-panels::page>