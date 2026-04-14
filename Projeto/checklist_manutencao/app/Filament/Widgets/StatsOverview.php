<?php

namespace App\Filament\Widgets;

use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\{Maquina, ManutencaoCorretiva, Inspecao};
use Filament\Widgets\StatsOverviewWidget as BaseWidget;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total de Máquinas', Maquina::count())
                ->icon('heroicon-o-cog-6-tooth')
                ->color('primary'),
            Stat::make('Funcionando', Maquina::where('status', 'funcionando')->count())
                ->icon('heroicon-o-check-circle')
                ->color('success'),
            Stat::make('Em Manutenção', Maquina::where('status', 'manutencao')->count())
                ->icon('heroicon-o-wrench-screwdriver')
                ->color('warning'),
            Stat::make('Quebradas', Maquina::where('status', 'quebrada')->count())
                ->icon('heroicon-o-x-circle')
                ->color('danger'),
            Stat::make('OS Abertas', ManutencaoCorretiva::where('status', 'aberto')->count())
                ->icon('heroicon-o-clipboard-document-list')
                ->color('warning'),
            Stat::make('Inspeções (mês)', Inspecao::whereMonth('data_inspecao', now()->month)->count())
                ->icon('heroicon-o-magnifying-glass')
                ->color('info'),
        ];
    }
}
