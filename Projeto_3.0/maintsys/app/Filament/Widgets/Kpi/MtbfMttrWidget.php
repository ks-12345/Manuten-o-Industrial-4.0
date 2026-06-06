<?php

namespace App\Filament\Widgets\Kpi;

use App\Services\IndicadorService;
use Filament\Widgets\Widget;
use Livewire\Attributes\Computed;
use Illuminate\Support\Facades\Auth;

class MtbfMttrWidget extends Widget
{
    protected static string  $view            = 'filament.widgets.kpi.mtbf-mttr';
    protected static ?string $heading         = 'Indicadores de Confiabilidade';
    protected static ?int    $sort            = 4;
    protected int | string | array $columnSpan = 'full';

    public string $periodo = 'mes'; // mes | trimestre | semestre | ano

    public function updatedPeriodo(): void
    {
        // Livewire reativa automaticamente
    }

    #[Computed]
    public function indicadores(): array
    {
        [$inicio, $fim] = $this->getRangeFromPeriodo();
        $service = app(IndicadorService::class);

        $mtbf        = $service->calcularMTBF(null, $inicio, $fim);
        $mttr        = $service->calcularMTTR(null, $inicio, $fim);
        $disponib    = $service->calcularDisponibilidade(null, $inicio, $fim);
        $resumo      = $service->resumoGeral($inicio, $fim);
        $porMaquina  = $service->falhasPorMaquina($inicio, $fim);

        return [
            'mtbf'          => $mtbf,
            'mttr'          => $mttr,
            'disponibilidade'=> $disponib,
            'total_falhas'  => $resumo['total_falhas'],
            'total_corretivas' => $resumo['total_corretivas'],
            'total_preventivas'=> $resumo['total_preventivas'],
            'custo_total'   => $resumo['custo_total'],
            'por_maquina'   => array_slice($porMaquina, 0, 5), // top 5
            'periodo'       => $resumo['periodo'],
        ];
    }

    private function getRangeFromPeriodo(): array
    {
        return match($this->periodo) {
            'trimestre' => [now()->startOfQuarter(), now()],
            'semestre'  => [now()->subMonths(6)->startOfMonth(), now()],
            'ano'       => [now()->startOfYear(), now()],
            default     => [now()->startOfMonth(), now()], // mes
        };
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('indicadores.view') ?? false;
    }
}