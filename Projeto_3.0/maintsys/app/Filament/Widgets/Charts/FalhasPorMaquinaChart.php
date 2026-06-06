<?php

namespace App\Filament\Widgets\Charts;

use App\Models\Ocorrencia;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\Auth;

class FalhasPorMaquinaChart extends ChartWidget
{
    protected static ?string $heading = 'Falhas por Máquina (últimos 30 dias)';
    protected static ?int    $sort    = 5;
    protected static string  $color   = 'danger';

    protected function getData(): array
    {
        $dados = Ocorrencia::with('maquina:id,nome')
            ->where('created_at', '>=', now()->subDays(30))
            ->selectRaw('maquina_id, COUNT(*) as total')
            ->groupBy('maquina_id')
            ->orderByDesc('total')
            ->limit(10)
            ->get();

        $gradiente = [
            '#ef4444','#f97316','#f59e0b','#eab308','#84cc16',
            '#22c55e','#14b8a6','#3b82f6','#6366f1','#a855f7',
        ];

        return [
            'labels'   => $dados->map(fn($d) => $d->maquina?->nome ?? 'N/A')->toArray(),
            'datasets' => [
                [
                    'label'           => 'Falhas',
                    'data'            => $dados->pluck('total')->toArray(),
                    'backgroundColor' => array_slice($gradiente, 0, $dados->count()),
                    'borderRadius'    => 6,
                    'borderWidth'     => 0,
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
                'x' => ['beginAtZero' => true, 'ticks' => ['stepSize' => 1]],
                'y' => ['ticks' => ['font' => ['size' => 11]]],
            ],
            'plugins' => [
                'legend' => ['display' => false],
            ],
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('indicadores.view') ?? false;
    }
}