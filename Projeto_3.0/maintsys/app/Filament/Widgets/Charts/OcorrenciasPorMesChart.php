<?php

namespace App\Filament\Widgets\Charts;

use App\Models\Corretiva;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;

class OcorrenciasPorMesChart extends ChartWidget
{
    protected static ?string $heading = 'Ocorrências vs Corretivas vs Preventivas (12 meses)';
    protected static ?int    $sort    = 3;
    protected static string  $color   = 'primary';
    protected int | string | array $columnSpan = 'full';

    protected function getData(): array
    {
        $meses  = collect();
        $labels = [];

        for ($i = 11; $i >= 0; $i--) {
            $data   = now()->subMonths($i);
            $labels[] = $data->format('M/y');
            $meses->push([
                'ano' => $data->year,
                'mes' => $data->month,
            ]);
        }

        $ocorrencias  = $this->contarPorMes(Ocorrencia::class,  'created_at');
        $corretivas   = $this->contarPorMes(Corretiva::class,   'created_at');
        $preventivas  = $this->contarPorMes(Preventiva::class,  'created_at', 'realizada');

        $mapear = fn($colecao) => $meses->map(fn($m) =>
            $colecao->where('ano', $m['ano'])->where('mes', $m['mes'])->first()?->total ?? 0
        )->toArray();

        return [
            'labels'   => $labels,
            'datasets' => [
                [
                    'label'           => 'Ocorrências Abertas',
                    'data'            => $mapear($ocorrencias),
                    'borderColor'     => '#f59e0b',
                    'backgroundColor' => 'rgba(245, 158, 11, 0.1)',
                    'tension'         => 0.4,
                    'fill'            => true,
                    'pointRadius'     => 4,
                ],
                [
                    'label'           => 'Corretivas',
                    'data'            => $mapear($corretivas),
                    'borderColor'     => '#ef4444',
                    'backgroundColor' => 'rgba(239, 68, 68, 0.1)',
                    'tension'         => 0.4,
                    'fill'            => true,
                    'pointRadius'     => 4,
                ],
                [
                    'label'           => 'Preventivas Realizadas',
                    'data'            => $mapear($preventivas),
                    'borderColor'     => '#22c55e',
                    'backgroundColor' => 'rgba(34, 197, 94, 0.1)',
                    'tension'         => 0.4,
                    'fill'            => true,
                    'pointRadius'     => 4,
                ],
            ],
        ];
    }

    private function contarPorMes(string $model, string $coluna, ?string $status = null)
    {
        return $model::query()
            ->when($status, fn($q) => $q->where('status', $status))
            ->selectRaw("EXTRACT(YEAR FROM {$coluna}) as ano, EXTRACT(MONTH FROM {$coluna}) as mes, COUNT(*) as total")
            ->where($coluna, '>=', now()->subMonths(12))
            ->whereNotNull($coluna)
            ->groupByRaw("EXTRACT(YEAR FROM {$coluna}), EXTRACT(MONTH FROM {$coluna})")
            ->get();
    }

    protected function getType(): string
    {
        return 'line';
    }

    protected function getOptions(): array
    {
        return [
            'scales' => [
                'y' => [
                    'beginAtZero' => true,
                    'ticks'       => ['stepSize' => 1],
                ],
            ],
            'plugins' => [
                'legend' => ['position' => 'top'],
            ],
        ];
    }

    public static function canView(): bool
    {
        return auth()->user()?->hasPermissionTo('dashboard.view') ?? false;
    }
}