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
use Illuminate\Support\Facades\Cache;

class StatsAdminWidget extends BaseWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $dados = Cache::remember('dashboard_stats_admin', now()->addMinutes(5), function () {
            return [
                'ocorrencias_abertas' => Ocorrencia::where('status', StatusOcorrencia::Aberta->value)->count(),
                'ocorrencias_abertas_chart' => Ocorrencia::where('status', StatusOcorrencia::Aberta->value)
                    ->selectRaw('COUNT(*) as count')
                    ->groupByRaw('DATE(created_at)')
                    ->pluck('count')
                    ->toArray(),
                'corretivas_em_andamento' => Corretiva::where('status', 'em_andamento')->count(),
                'preventivas_atrasadas' => Preventiva::where('status', 'atrasada')
                    ->orWhere(fn ($q) => $q->where('status', 'pendente')->where('data_prevista', '<', now()))
                    ->count(),
                'aguardando_orcamento' => Ocorrencia::where('status', StatusOcorrencia::AguardandoOrcamento->value)->count(),
                'aguardando_peca' => Ocorrencia::where('status', StatusOcorrencia::AguardandoPeca->value)->count(),
                'maquinas_quebradas' => Maquina::where('status', StatusMaquina::Quebrada->value)->count(),
            ];
        });

        return [
            Stat::make('Ocorrencias Abertas', $dados['ocorrencias_abertas'])
                ->description('Aguardando tecnico')
                ->descriptionIcon('heroicon-o-exclamation-triangle')
                ->color('warning')
                ->chart($dados['ocorrencias_abertas_chart']),

            Stat::make('Em Corretiva', $dados['corretivas_em_andamento'])
                ->description('Manutencoes em execucao')
                ->descriptionIcon('heroicon-o-wrench-screwdriver')
                ->color('info'),

            Stat::make('Preventivas Atrasadas', $dados['preventivas_atrasadas'])
                ->description('Necessitam atencao')
                ->descriptionIcon('heroicon-o-calendar-days')
                ->color('danger'),

            Stat::make('Aguard. Orcamento', $dados['aguardando_orcamento'])
                ->description('Pecas sendo cotadas')
                ->descriptionIcon('heroicon-o-currency-dollar')
                ->color('orange'),

            Stat::make('Aguardando Peca', $dados['aguardando_peca'])
                ->description('Pecas encomendadas')
                ->descriptionIcon('heroicon-o-cube')
                ->color('purple'),

            Stat::make('Maquinas Quebradas', $dados['maquinas_quebradas'])
                ->description('Fora de operacao')
                ->descriptionIcon('heroicon-o-x-circle')
                ->color('danger'),
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasRole('admin') ?? false;
    }
}
