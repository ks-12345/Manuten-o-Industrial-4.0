<?php

namespace App\Filament\Widgets;

use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Models\Corretiva;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\Auth;

class StatsAdminWidget extends BaseWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        return [
            Stat::make('Ocorrências Abertas', Ocorrencia::where('status', StatusOcorrencia::Aberta->value)->count())
                ->description('Aguardando técnico')
                ->descriptionIcon('heroicon-o-exclamation-triangle')
                ->color('warning')
                ->chart(Ocorrencia::where('status', StatusOcorrencia::Aberta->value)
                    ->selectRaw('COUNT(*) as count')
                    ->groupByRaw('DATE(created_at)')
                    ->pluck('count')->toArray()),

            Stat::make('Em Corretiva', Corretiva::where('status', 'em_andamento')->count())
                ->description('Manutenções em execução')
                ->descriptionIcon('heroicon-o-wrench-screwdriver')
                ->color('info'),

            Stat::make('Preventivas Atrasadas', Preventiva::where('status', 'atrasada')
                ->orWhere(fn($q) => $q->where('status', 'pendente')->where('data_prevista', '<', now()))
                ->count())
                ->description('Necessitam atenção')
                ->descriptionIcon('heroicon-o-calendar-days')
                ->color('danger'),

            Stat::make('Aguard. Orçamento', Ocorrencia::where('status', StatusOcorrencia::AguardandoOrcamento->value)->count())
                ->description('Peças sendo cotadas')
                ->descriptionIcon('heroicon-o-currency-dollar')
                ->color('orange'),

            Stat::make('Aguardando Peça', Ocorrencia::where('status', StatusOcorrencia::AguardandoPeca->value)->count())
                ->description('Peças encomendadas')
                ->descriptionIcon('heroicon-o-cube')
                ->color('purple'),

            Stat::make('Máquinas Quebradas', Maquina::where('status', StatusMaquina::Quebrada->value)->count())
                ->description('Fora de operação')
                ->descriptionIcon('heroicon-o-x-circle')
                ->color('danger'),
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasRole('admin') ?? false;
    }
}