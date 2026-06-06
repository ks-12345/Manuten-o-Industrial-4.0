<?php

namespace App\Filament\Widgets\Charts;

use App\Enums\StatusOcorrencia;
use App\Models\Ocorrencia;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\Auth;

class OcorrenciasPorStatusChart extends ChartWidget
{
    protected static ?string $heading = 'Ocorrências por Status';
    protected static ?int    $sort    = 2;
    protected static string  $color   = 'info';

    protected function getData(): array
    {
        $dados = collect(StatusOcorrencia::cases())->mapWithKeys(fn($status) => [
            $status->value => Ocorrencia::where('status', $status->value)->count(),
        ]);

        return [
            'labels'   => collect(StatusOcorrencia::cases())->map(fn($s) => $s->getLabel())->toArray(),
            'datasets' => [
                [
                    'label'           => 'Ocorrências',
                    'data'            => $dados->values()->toArray(),
                    'backgroundColor' => [
                        '#f59e0b', // aberta     - warning
                        '#3b82f6', // em_analise - info
                        '#f97316', // aguardando_orcamento
                        '#a855f7', // aguardando_peca
                        '#6366f1', // em_corretiva
                        '#22c55e', // finalizada
                        '#ef4444', // cancelada
                    ],
                    'borderWidth'     => 2,
                    'borderColor'     => '#ffffff',
                ],
            ],
        ];
    }

    protected function getType(): string
    {
        return 'doughnut';
    }

    protected function getOptions(): array
    {
        return [
            'plugins' => [
                'legend' => ['position' => 'bottom'],
                'tooltip' => [
                    'callbacks' => [],
                ],
            ],
            'cutout' => '65%',
        ];
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('dashboard.view') ?? false;
    }
}