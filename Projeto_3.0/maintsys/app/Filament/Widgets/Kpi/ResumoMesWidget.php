<?php

namespace App\Filament\Widgets\Kpi;

use App\Models\Corretiva;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\Auth;

class ResumoMesWidget extends BaseWidget
{
    protected ?string $heading = 'Resumo do Mês Atual';
    protected static ?int    $sort    = 1;

    protected function getStats(): array
    {
        $inicio = now()->startOfMonth();
        $fim    = now();

        // Tendência vs mês anterior
        $inicioAnterior = now()->subMonth()->startOfMonth();
        $fimAnterior    = now()->subMonth()->endOfMonth();

        $ocorrenciasMes      = Ocorrencia::whereBetween('created_at', [$inicio, $fim])->count();
        $ocorrenciasAnterior = Ocorrencia::whereBetween('created_at', [$inicioAnterior, $fimAnterior])->count();
        $tendenciaOcorrencias = $ocorrenciasMes - $ocorrenciasAnterior;

        $corretivasMes  = Corretiva::whereBetween('created_at', [$inicio, $fim])->count();
        $preventivasMes = Preventiva::where('status', 'realizada')
            ->whereBetween('data_realizada', [$inicio->toDateString(), $fim->toDateString()])
            ->count();

        $custoCorretivasMes = Corretiva::where('status', 'finalizada')
            ->whereBetween('fim', [$inicio, $fim])
            ->selectRaw('SUM(custo_pecas + custo_mao_obra) as total')
            ->value('total') ?? 0;

        $custoPreventMes = Preventiva::where('status', 'realizada')
            ->whereBetween('data_realizada', [$inicio->toDateString(), $fim->toDateString()])
            ->sum('custo');

        $finalizadas = Ocorrencia::where('status', 'finalizada')
            ->whereBetween('finalizada_em', [$inicio, $fim])
            ->count();

        return [
            Stat::make('Ocorrências no Mês', $ocorrenciasMes)
                ->description($tendenciaOcorrencias >= 0
                    ? "+{$tendenciaOcorrencias} vs mês anterior"
                    : "{$tendenciaOcorrencias} vs mês anterior")
                ->descriptionIcon($tendenciaOcorrencias >= 0 ? 'heroicon-m-arrow-trending-up' : 'heroicon-m-arrow-trending-down')
                ->color($tendenciaOcorrencias <= 0 ? 'success' : 'danger'),

            Stat::make('Corretivas Realizadas', $corretivasMes)
                ->description("+ {$preventivasMes} preventivas")
                ->descriptionIcon('heroicon-o-wrench-screwdriver')
                ->color('info'),

            Stat::make('Ocorrências Resolvidas', $finalizadas)
                ->description($ocorrenciasMes > 0
                    ? round($finalizadas / $ocorrenciasMes * 100, 0) . '% de resolução'
                    : 'Nenhuma aberta')
                ->color('success'),

            Stat::make('Custo Total de Manutenção',
                'R$ ' . number_format($custoCorretivasMes + $custoPreventMes, 2, ',', '.'))
                ->description('R$ ' . number_format($custoCorretivasMes, 2, ',', '.') . ' corretivas · R$ ' . number_format($custoPreventMes, 2, ',', '.') . ' preventivas')
                ->descriptionIcon('heroicon-o-banknotes')
                ->color('warning'),
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasRole('admin') ?? false;
    }
}