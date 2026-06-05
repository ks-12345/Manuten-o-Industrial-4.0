<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Filtros --}}
        <x-filament::section>
            <x-slot name="heading">📋 Parâmetros do Relatório</x-slot>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm font-medium mb-1 text-gray-700 dark:text-gray-300">Data Inicial</label>
                    <input wire:model.live="dataInicio" type="date"
                           class="w-full rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-3 py-2"/>
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1 text-gray-700 dark:text-gray-300">Data Final</label>
                    <input wire:model.live="dataFim" type="date"
                           class="w-full rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-3 py-2"/>
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1 text-gray-700 dark:text-gray-300">Setor</label>
                    <select wire:model.live="setorId"
                            class="w-full rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-3 py-2">
                        <option value="">Todos os Setores</option>
                        @foreach($this->getSetores() as $setor)
                            <option value="{{ $setor->id }}">{{ $setor->nome }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1 text-gray-700 dark:text-gray-300">Máquina</label>
                    <select wire:model.live="maquinaId"
                            class="w-full rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 px-3 py-2">
                        <option value="">Todas as Máquinas</option>
                        @foreach($this->getMaquinas() as $maquina)
                            <option value="{{ $maquina->id }}">{{ $maquina->nome }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="flex items-end">
                    <x-filament::button onclick="window.print()" icon="heroicon-o-printer" color="gray">
                        Imprimir / PDF
                    </x-filament::button>
                </div>
            </div>
        </x-filament::section>

        @php $r = $this->relatorio; @endphp

        {{-- Totalizadores --}}
        <div class="grid grid-cols-2 md:grid-cols-5 gap-3">
            @php
                $totais = [
                    ['label'=>'Ocorrências','valor'=>$r['totais']['ocorrencias'],'cor'=>'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400','emoji'=>'⚠️'],
                    ['label'=>'Corretivas','valor'=>$r['totais']['corretivas'],'cor'=>'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400','emoji'=>'🔧'],
                    ['label'=>'Preventivas','valor'=>$r['totais']['preventivas'],'cor'=>'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400','emoji'=>'📅'],
                    ['label'=>'Tempo Total','valor'=>gmdate('H\h i\m', $r['totais']['tempo_total'] * 60),'cor'=>'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400','emoji'=>'⏱'],
                    ['label'=>'Custo Total','valor'=>'R$ '.number_format($r['totais']['custo_total'],2,',','.'),'cor'=>'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400','emoji'=>'💰'],
                ];
            @endphp
            @foreach($totais as $t)
                <div class="rounded-xl p-4 {{ $t['cor'] }} text-center">
                    <div class="text-2xl mb-1">{{ $t['emoji'] }}</div>
                    <div class="text-xl font-bold">{{ $t['valor'] }}</div>
                    <div class="text-xs font-medium mt-1 opacity-80">{{ $t['label'] }}</div>
                </div>
            @endforeach
        </div>

        {{-- Ocorrências --}}
        @if($r['ocorrencias']->isNotEmpty())
            <x-filament::section>
                <x-slot name="heading">⚠️ Ocorrências ({{ $r['ocorrencias']->count() }})</x-slot>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm border-collapse">
                        <thead class="bg-gray-50 dark:bg-gray-800">
                            <tr>
                                @foreach(['Código','Máquina','Setor','Título','Prioridade','Status','Professor','Técnico','Data'] as $h)
                                    <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400 border-b border-gray-200 dark:border-gray-700">{{ $h }}</th>
                                @endforeach
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($r['ocorrencias'] as $oc)
                                <tr class="border-b border-gray-100 dark:border-gray-800 hover:bg-gray-50 dark:hover:bg-gray-800/40">
                                    <td class="py-2 px-3 font-mono text-primary-600 font-bold">{{ $oc->codigo }}</td>
                                    <td class="py-2 px-3">{{ $oc->maquina?->nome }}</td>
                                    <td class="py-2 px-3 text-gray-500">{{ $oc->maquina?->setor?->nome }}</td>
                                    <td class="py-2 px-3">{{ Str::limit($oc->titulo, 30) }}</td>
                                    <td class="py-2 px-3">
                                        <span class="px-2 py-0.5 rounded-full text-xs font-medium
                                                     {{ match($oc->prioridade->value){
                                                         'critica'=>'bg-red-100 text-red-700',
                                                         'alta'=>'bg-orange-100 text-orange-700',
                                                         'media'=>'bg-amber-100 text-amber-700',
                                                         default=>'bg-green-100 text-green-700'} }}">
                                            {{ $oc->prioridade->getLabel() }}
                                        </span>
                                    </td>
                                    <td class="py-2 px-3">
                                        <span class="text-xs">{{ $oc->status->getLabel() }}</span>
                                    </td>
                                    <td class="py-2 px-3 text-gray-500">{{ $oc->professor?->name }}</td>
                                    <td class="py-2 px-3 text-gray-500">{{ $oc->tecnico?->name ?? '—' }}</td>
                                    <td class="py-2 px-3 text-gray-400 text-xs">{{ $oc->created_at->format('d/m/Y') }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </x-filament::section>
        @endif

        {{-- Corretivas --}}
        @if($r['corretivas']->isNotEmpty())
            <x-filament::section>
                <x-slot name="heading">🔧 Corretivas ({{ $r['corretivas']->count() }})</x-slot>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm border-collapse">
                        <thead class="bg-gray-50 dark:bg-gray-800">
                            <tr>
                                @foreach(['Máquina','Tipo','Técnico','Problema','Status','Tempo','C. Peças','C. M.O.','Total','Data'] as $h)
                                    <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400 border-b border-gray-200 dark:border-gray-700">{{ $h }}</th>
                                @endforeach
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($r['corretivas'] as $c)
                                <tr class="border-b border-gray-100 dark:border-gray-800">
                                    <td class="py-2 px-3">{{ $c->maquina?->nome }}</td>
                                    <td class="py-2 px-3 text-xs">{{ $c->tipo->getLabel() }}</td>
                                    <td class="py-2 px-3 text-gray-500">{{ $c->tecnico?->name }}</td>
                                    <td class="py-2 px-3">{{ Str::limit($c->problema, 30) }}</td>
                                    <td class="py-2 px-3">
                                        <span class="{{ $c->estaFinalizada() ? 'text-green-600' : 'text-amber-600' }} text-xs font-semibold">
                                            {{ $c->estaFinalizada() ? 'Finalizada' : 'Em andamento' }}
                                        </span>
                                    </td>
                                    <td class="py-2 px-3 text-gray-500 font-mono">{{ $c->tempo_reparo ? gmdate('H\h i\m', $c->tempo_reparo * 60) : '—' }}</td>
                                    <td class="py-2 px-3 text-red-600 font-mono">R$ {{ number_format($c->custo_pecas, 2, ',', '.') }}</td>
                                    <td class="py-2 px-3 text-orange-600 font-mono">R$ {{ number_format($c->custo_mao_obra, 2, ',', '.') }}</td>
                                    <td class="py-2 px-3 font-bold font-mono">R$ {{ number_format($c->custoTotal(), 2, ',', '.') }}</td>
                                    <td class="py-2 px-3 text-gray-400 text-xs">{{ $c->created_at->format('d/m/Y') }}</td>
                                </tr>
                            @endforeach
                            <tr class="bg-gray-100 dark:bg-gray-800 font-bold">
                                <td class="py-2 px-3" colspan="6">TOTAL CORRETIVAS</td>
                                <td class="py-2 px-3 text-red-600">R$ {{ number_format($r['corretivas']->sum('custo_pecas'), 2, ',', '.') }}</td>
                                <td class="py-2 px-3 text-orange-600">R$ {{ number_format($r['corretivas']->sum('custo_mao_obra'), 2, ',', '.') }}</td>
                                <td class="py-2 px-3 text-purple-600">R$ {{ number_format($r['corretivas']->sum(fn($c) => $c->custoTotal()), 2, ',', '.') }}</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </x-filament::section>
        @endif

        {{-- Preventivas --}}
        @if($r['preventivas']->isNotEmpty())
            <x-filament::section>
                <x-slot name="heading">📅 Preventivas ({{ $r['preventivas']->count() }})</x-slot>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm border-collapse">
                        <thead class="bg-gray-50 dark:bg-gray-800">
                            <tr>
                                @foreach(['Máquina','Setor','Periodicidade','Prev. para','Realizada em','Técnico','Tempo','Custo','Status'] as $h)
                                    <th class="text-left py-2 px-3 font-semibold text-gray-600 dark:text-gray-400 border-b border-gray-200 dark:border-gray-700">{{ $h }}</th>
                                @endforeach
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($r['preventivas'] as $p)
                                <tr class="border-b border-gray-100 dark:border-gray-800">
                                    <td class="py-2 px-3">{{ $p->maquina?->nome }}</td>
                                    <td class="py-2 px-3 text-gray-500">{{ $p->maquina?->setor?->nome }}</td>
                                    <td class="py-2 px-3 text-xs">{{ $p->periodicidade->getLabel() }}</td>
                                    <td class="py-2 px-3 {{ $p->estaAtrasada() ? 'text-red-600 font-bold' : '' }}">
                                        {{ $p->data_prevista->format('d/m/Y') }}
                                    </td>
                                    <td class="py-2 px-3 text-green-600">{{ $p->data_realizada?->format('d/m/Y') ?? '—' }}</td>
                                    <td class="py-2 px-3 text-gray-500">{{ $p->tecnico?->name ?? '—' }}</td>
                                    <td class="py-2 px-3 font-mono text-gray-500">{{ $p->tempo_execucao ? gmdate('H\h i\m', $p->tempo_execucao * 60) : '—' }}</td>
                                    <td class="py-2 px-3 font-mono">R$ {{ number_format($p->custo, 2, ',', '.') }}</td>
                                    <td class="py-2 px-3">
                                        <span class="text-xs font-semibold {{ match($p->status){
                                            'realizada'=>'text-green-600',
                                            'atrasada'=>'text-red-600',
                                            'em_andamento'=>'text-blue-600',
                                            default=>'text-amber-600'} }}">
                                            {{ match($p->status){'realizada'=>'✅ Realizada','atrasada'=>'❌ Atrasada','em_andamento'=>'🔄 Em andamento',default=>'⏳ Pendente'} }}
                                        </span>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </x-filament::section>
        @endif
    </div>

    <style>
        @media print {
            nav, header, .fi-sidebar, .fi-topbar, button, [x-data], .no-print { display: none !important; }
            .fi-main { padding: 0 !important; margin: 0 !important; }
            table { font-size: 11px; }
        }
    </style>
</x-filament-panels::page>