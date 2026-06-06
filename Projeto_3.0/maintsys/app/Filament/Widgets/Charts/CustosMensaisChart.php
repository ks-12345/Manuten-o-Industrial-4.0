<?php

namespace App\Filament\Widgets\Charts;

use App\Models\Corretiva;
use App\Models\Preventiva;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\Auth;

class CustosMensaisChart extends ChartWidget
{
    protected static ?string $heading = 'Custos de Manutenção por Mês (R$)';
    protected static ?int    $sort    = 7;
    protected static string  $color   = 'warning';
    protected int | string | array $columnSpan = 'full';

    protected function getData(): array
    {
        $labels           = [];
        $custosCorretivas = [];
        $custosPreventivas= [];

        for ($i = 11; $i >= 0; $i--) {
            $data    = now()->subMonths($i);
            $labels[]= $data->format('M/y');
            $ano     = $data->year;
            $mes     = $data->month;

            $custosCorretivas[] = (float) Corretiva::where('status', 'finalizada')
                ->whereYear('fim', $ano)
                ->whereMonth('fim', $mes)
                ->selectRaw('SUM(custo_pecas + custo_mao_obra) as total')
                ->value('total') ?? 0;

            $custosPreventivas[] = (float) Preventiva::where('status', 'realizada')
                ->whereYear('data_realizada', $ano)
                ->whereMonth('data_realizada', $mes)
                ->sum('custo');
        }

        return [
            'labels'   => $labels,
            'datasets' => [
                [
                    'label'           => 'Corretivas (R$)',
                    'data'            => $custosCorretivas,
                    'backgroundColor' => 'rgba(239,68,68,0.7)',
                    'borderColor'     => '#ef4444',
                    'borderWidth'     => 2,
                    'borderRadius'    => 4,
                    'type'            => 'bar',
                ],
                [
                    'label'           => 'Preventivas (R$)',
                    'data'            => $custosPreventivas,
                    'backgroundColor' => 'rgba(34,197,94,0.7)',
                    'borderColor'     => '#22c55e',
                    'borderWidth'     => 2,
                    'borderRadius'    => 4,
                    'type'            => 'bar',
                ],
                [
                    'label'       => 'Total (R$)',
                    'data'        => array_map(fn($c, $p) => $c + $p, $custosCorretivas, $custosPreventivas),
                    'borderColor' => '#6366f1',
                    'borderWidth' => 2,
                    'tension'     => 0.4,
                    'type'        => 'line',
                    'fill'        => false,
                    'pointRadius' => 4,
                    'yAxisID'     => 'y',
                ],
            ],
        ];
    }

    protected function getType(): string
    {
        return 'bar'; // mixed via dataset type override
    }

    protected function getOptions(): array
    {
        return [
            'scales' => [
                'y' => [
                    'beginAtZero' => true,
                    'ticks'       => [
                        'callback' => "function(value){ return 'R$ ' + value.toLocaleString('pt-BR'); }",
                    ],
                ],
            ],
            'plugins' => [
                'legend' => ['position' => 'top'],
                'tooltip' => [
                    'callbacks' => [
                        'label' => "function(ctx){ return ctx.dataset.label + ': R$ ' + ctx.raw.toLocaleString('pt-BR', {minimumFractionDigits:2}); }",
                    ],
                ],
            ],
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('indicadores.view') ?? false;
    }
}