<?php

namespace App\Filament\Pages;

use App\Filament\Widgets\AlertasWidget;
use App\Filament\Widgets\Charts\CustosMensaisChart;
use App\Filament\Widgets\Charts\FalhasPorMaquinaChart;
use App\Filament\Widgets\Charts\FalhasPorSetorChart;
use App\Filament\Widgets\Charts\OcorrenciasPorMesChart;
use App\Filament\Widgets\Charts\OcorrenciasPorStatusChart;
use App\Filament\Widgets\Charts\PreventivasRealizadasChart;
use App\Filament\Widgets\Kpi\MtbfMttrWidget;
use App\Filament\Widgets\Kpi\ResumoMesWidget;
use App\Filament\Widgets\OcorrenciasRecentesWidget;
use App\Filament\Widgets\PreventivasPendentesWidget;
use App\Filament\Widgets\StatsAdminWidget;
use App\Filament\Widgets\StatsProfessorWidget;
use App\Filament\Widgets\StatsTecnicoWidget;
use Filament\Pages\Dashboard as BaseDashboard;

class Dashboard extends BaseDashboard
{
    protected static ?string $navigationIcon = 'heroicon-o-home';
    protected static ?string $title          = 'Painel Principal';

    public function getWidgets(): array
    {
        $user   = auth()->user();
        $perfil = session('perfil_ativo', $user->roles->first()?->name);

        if ($user->hasRole('admin')) {
            return [
                StatsAdminWidget::class,
                AlertasWidget::class,
                ResumoMesWidget::class,
                OcorrenciasPorStatusChart::class,
                OcorrenciasPorMesChart::class,
                FalhasPorMaquinaChart::class,
                FalhasPorSetorChart::class,
                CustosMensaisChart::class,
                MtbfMttrWidget::class,
                PreventivasRealizadasChart::class,
                OcorrenciasRecentesWidget::class,
                PreventivasPendentesWidget::class,
            ];
        }

        if ($perfil === 'professor') {
            return [
                StatsProfessorWidget::class,
                OcorrenciasPorStatusChart::class,
                OcorrenciasRecentesWidget::class,
            ];
        }

        if ($perfil === 'tecnico') {
            return [
                StatsTecnicoWidget::class,
                AlertasWidget::class,
                OcorrenciasPorMesChart::class,
                PreventivasRealizadasChart::class,
                OcorrenciasRecentesWidget::class,
                PreventivasPendentesWidget::class,
            ];
        }

        return [StatsAdminWidget::class];
    }

    public function getColumns(): int | string | array
    {
        return 2;
    }
}
