<?php

namespace App\Filament\Widgets\Charts;

use App\Models\Ocorrencia;
use App\Models\Setor;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class FalhasPorSetorChart extends ChartWidget
{
    protected static ?string $heading = 'Falhas por Setor (últimos 30 dias)';
   protected static ?string $pollingInterval = '60s';

    protected static bool $isLazy = true;

    protected static string  $color   = 'warning';

    protected function getData(): array
    {
        $setores = Setor::with(['maquinas' => fn($q) => $q->withCount([
            'ocorrencias as falhas_count' => fn($q) =>
                $q->where('created_at', '>=', now()->subDays(30)),
        ])])->ativos()->get();

        $labels = $setores->pluck('nome')->toArray();
        $valores = $setores->map(fn($s) => $s->maquinas->sum('falhas_count'))->toArray();

        return [
            'labels'   => $labels,
            'datasets' => [
                [
                    'label'           => 'Falhas',
                    'data'            => $valores,
                    'backgroundColor' => [
                        'rgba(239,68,68,0.7)','rgba(249,115,22,0.7)','rgba(234,179,8,0.7)',
                        'rgba(34,197,94,0.7)','rgba(59,130,246,0.7)','rgba(168,85,247,0.7)',
                    ],
                    'borderColor'     => [
                        '#ef4444','#f97316','#eab308',
                        '#22c55e','#3b82f6','#a855f7',
                    ],
                    'borderWidth' => 2,
                    'borderRadius'=> 6,
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
            'scales' => [
                'y' => ['beginAtZero' => true, 'ticks' => ['stepSize' => 1]],
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