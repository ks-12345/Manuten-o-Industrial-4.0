<?php

namespace App\Filament\Widgets\Kpi;

use App\Enums\StatusOcorrencia;
use App\Models\Corretiva;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class ResumoMesWidget extends BaseWidget
{
    protected ?string $heading = 'Resumo do Mes Atual';
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $dados = Cache::remember('dashboard_kpi_resumo_mes', now()->addMinutes(10), function () {
            $inicio = now()->startOfMonth();
            $fim = now();

            $inicioAnterior = now()->subMonth()->startOfMonth();
            $fimAnterior = now()->subMonth()->endOfMonth();

            $ocorrenciasMes = Ocorrencia::whereBetween('created_at', [$inicio, $fim])->count();
            $ocorrenciasAnterior = Ocorrencia::whereBetween('created_at', [$inicioAnterior, $fimAnterior])->count();

            $corretivasMes = Corretiva::whereBetween('created_at', [$inicio, $fim])->count();
            $preventivasMes = Preventiva::where('status', 'realizada')
                ->whereBetween('data_realizada', [$inicio->toDateString(), $fim->toDateString()])
                ->count();

            $custoCorretivasMes = Corretiva::where('status', 'finalizada')
                ->whereBetween('fim', [$inicio, $fim])
                ->selectRaw('SUM(custo_pecas + custo_mao_obra) as total')
                ->value('total') ?? 0;

            $custoPreventivasMes = Preventiva::where('status', 'realizada')
                ->whereBetween('data_realizada', [$inicio->toDateString(), $fim->toDateString()])
                ->sum('custo');

            $finalizadas = Ocorrencia::where('status', StatusOcorrencia::Concluida->value)
                ->whereBetween('finalizada_em', [$inicio, $fim])
                ->count();

            return [
                'ocorrencias_mes' => $ocorrenciasMes,
                'tendencia_ocorrencias' => $ocorrenciasMes - $ocorrenciasAnterior,
                'corretivas_mes' => $corretivasMes,
                'preventivas_mes' => $preventivasMes,
                'custo_corretivas_mes' => $custoCorretivasMes,
                'custo_preventivas_mes' => $custoPreventivasMes,
                'finalizadas' => $finalizadas,
            ];
        });

        return [
            Stat::make('Ocorrencias no Mes', $dados['ocorrencias_mes'])
                ->description($dados['tendencia_ocorrencias'] >= 0
                    ? "+{$dados['tendencia_ocorrencias']} vs mes anterior"
                    : "{$dados['tendencia_ocorrencias']} vs mes anterior")
                ->descriptionIcon($dados['tendencia_ocorrencias'] >= 0 ? 'heroicon-m-arrow-trending-up' : 'heroicon-m-arrow-trending-down')
                ->color($dados['tendencia_ocorrencias'] <= 0 ? 'success' : 'danger'),

            Stat::make('Corretivas Realizadas', $dados['corretivas_mes'])
                ->description("+ {$dados['preventivas_mes']} preventivas")
                ->descriptionIcon('heroicon-o-wrench-screwdriver')
                ->color('info'),

            Stat::make('Ocorrencias Resolvidas', $dados['finalizadas'])
                ->description($dados['ocorrencias_mes'] > 0
                    ? round($dados['finalizadas'] / $dados['ocorrencias_mes'] * 100, 0) . '% de resolucao'
                    : 'Nenhuma aberta')
                ->color('success'),

            Stat::make(
                'Custo Total de Manutencao',
                'R$ ' . number_format($dados['custo_corretivas_mes'] + $dados['custo_preventivas_mes'], 2, ',', '.')
            )
                ->description('R$ ' . number_format($dados['custo_corretivas_mes'], 2, ',', '.') . ' corretivas - R$ ' . number_format($dados['custo_preventivas_mes'], 2, ',', '.') . ' preventivas')
                ->descriptionIcon('heroicon-o-banknotes')
                ->color('warning'),
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasRole('admin') ?? false;
    }
}
