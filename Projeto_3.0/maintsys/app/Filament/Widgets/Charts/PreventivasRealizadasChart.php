<?php

namespace App\Filament\Widgets\Charts;

use App\Models\Preventiva;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\Auth;

class PreventivasRealizadasChart extends ChartWidget
{
    protected static ?string $heading = 'Preventivas: Realizadas vs Pendentes (12 meses)';
    protected static ?string $pollingInterval = '60s';

    protected static bool $isLazy = true;

    protected static string  $color   = 'success';

    protected function getData(): array
    {
        $labels    = [];
        $realizadas = [];
        $pendentes  = [];

        for ($i = 11; $i >= 0; $i--) {
            $data      = now()->subMonths($i);
            $labels[]  = $data->format('M/y');
            $ano       = $data->year;
            $mes       = $data->month;

            $realizadas[] = Preventiva::where('status', 'realizada')
                ->whereYear('data_realizada', $ano)
                ->whereMonth('data_realizada', $mes)
                ->count();

            $pendentes[] = Preventiva::whereIn('status', ['pendente', 'atrasada'])
                ->whereYear('data_prevista', $ano)
                ->whereMonth('data_prevista', $mes)
                ->count();
        }

        return [
            'labels'   => $labels,
            'datasets' => [
                [
                    'label'           => 'Realizadas',
                    'data'            => $realizadas,
                    'backgroundColor' => 'rgba(34,197,94,0.7)',
                    'borderColor'     => '#22c55e',
                    'borderWidth'     => 2,
                    'borderRadius'    => 4,
                ],
                [
                    'label'           => 'Pendentes / Atrasadas',
                    'data'            => $pendentes,
                    'backgroundColor' => 'rgba(239,68,68,0.7)',
                    'borderColor'     => '#ef4444',
                    'borderWidth'     => 2,
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
            'scales' => [
                'x' => ['stacked' => false],
                'y' => ['beginAtZero' => true, 'ticks' => ['stepSize' => 1]],
            ],
            'plugins' => [
                'legend' => ['position' => 'top'],
            ],
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('dashboard.view') ?? false;
    }
}