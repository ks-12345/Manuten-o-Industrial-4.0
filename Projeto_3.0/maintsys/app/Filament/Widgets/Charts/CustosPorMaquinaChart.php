<?php

namespace App\Filament\Widgets\Charts;

use App\Services\IndicadorService;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\Auth;

class CustosPorMaquinaChart extends ChartWidget
{
    protected static ?string $heading = 'Custo Total por Máquina (mês atual)';
    protected static ?int    $sort    = 9;
    protected static string  $color   = 'purple';
    protected int | string | array $columnSpan = 'full';

    protected function getData(): array
    {
        $dados = app(IndicadorService::class)
            ->custosPorMaquina(now()->startOfMonth(), now());

        $top10 = array_slice($dados, 0, 10);

        return [
            'labels'   => collect($top10)->pluck('maquina')->toArray(),
            'datasets' => [
                [
                    'label'           => 'Corretivas (R$)',
                    'data'            => collect($top10)->pluck('custo_corretiva')->toArray(),
                    'backgroundColor' => 'rgba(239,68,68,0.7)',
                    'borderRadius'    => 4,
                ],
                [
                    'label'           => 'Preventivas (R$)',
                    'data'            => collect($top10)->pluck('custo_preventiva')->toArray(),
                    'backgroundColor' => 'rgba(34,197,94,0.7)',
                    'borderRadius'    => 4,
                ],
            ],
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }

    protected function getOptions(): array
    {
        return [
            'indexAxis' => 'y',
            'scales'    => [
                'x' => [
                    'stacked'     => true,
                    'beginAtZero' => true,
                ],
                'y' => ['stacked' => true],
            ],
            'plugins' => [
                'legend' => ['position' => 'top'],
            ],
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('indicadores.view') ?? false;
    }
}