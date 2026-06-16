<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Filtros (Adicionada a classe 'no-print' para sumir no PDF) --}}
        <x-filament::section class="no-print">
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

    {{-- CSS Corrigido para Impressão limpa no Dark e Light Mode --}}
    <style>
        @media print {
            /* Esconde menus, barras laterais, botões e formulário de filtros */
            nav, header, .fi-sidebar, .fi-topbar, button, .no-print, .fi-ac-action { 
                display: none !important; 
            }
            
            /* Remove margens e espaçamentos do container principal do Filament */
            .fi-main, .fi-layout, html, body { 
                padding: 0 !important; 
                margin: 0 !important; 
                background-color: #ffffff !important;
                color: #111111 !important;
            }

            /* Força os textos a ficarem legíveis (pretos) no papel */
            h1, h2, div, span, td, th, p {
                color: #111111 !important;
            }

            /* Estiliza os cartões de totais para que fiquem visíveis em fundo claro */
            .card-total {
                background-color: #f3f4f6 !important;
                border: 1px solid #e5e7eb !important;
                color: #111111 !important;
            }
            .valor-total, .label-total {
                color: #111111 !important;
                opacity: 1 !important;
            }

            /* Garante que o container das tabelas (Filament Sections) apareça */
            .secao-relatorio, .fi-section {
                background: #ffffff !important;
                border: 1px solid #d1d5db !important;
                box-shadow: none !important;
                margin-bottom: 1.5rem !important;
            }

            /* Configuração fina para as tabelas de dados */
            table { 
                font-size: 11px !important; 
                width: 100% !important;
                border-collapse: collapse !important;
            }
            th {
                background-color: #f9fafb !important;
                color: #374151 !important;
                border-bottom: 2px solid #e5e7eb !important;
            }
            td {
                border-bottom: 1px solid #e5e7eb !important;
            }
            .linha-total-tabela {
                background-color: #f3f4f6 !important;
            }
        }
    </style>
</x-filament-panels::page>