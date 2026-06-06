<?php

namespace App\Filament\Widgets;

use App\Models\Corretiva;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\Auth;

class StatsTecnicoWidget extends BaseWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $userId = Auth::id();

        return [
            Stat::make('Ocorrências Atribuídas', Ocorrencia::where('tecnico_id', $userId)
                ->whereNotIn('status', ['finalizada', 'cancelada'])->count())
                ->description('Em andamento')
                ->descriptionIcon('heroicon-o-clipboard-document')
                ->color('primary'),

            Stat::make('Abertas s/ Técnico', Ocorrencia::where('status', 'aberta')->whereNull('tecnico_id')->count())
                ->description('Disponíveis para assumir')
                ->descriptionIcon('heroicon-o-hand-raised')
                ->color('warning'),

            Stat::make('Preventivas Pendentes', Preventiva::where('tecnico_id', $userId)
                ->whereIn('status', ['pendente', 'atrasada'])->count()
                + Preventiva::whereNull('tecnico_id')->whereIn('status', ['pendente', 'atrasada'])->count())
                ->description('Para executar')
                ->descriptionIcon('heroicon-o-calendar-days')
                ->color('orange'),

            Stat::make('Corretivas Abertas', Corretiva::where('tecnico_id', $userId)
                ->where('status', 'em_andamento')->count())
                ->description('Em execução')
                ->descriptionIcon('heroicon-o-wrench-screwdriver')
                ->color('info'),
        ];
    }

    public static function canView(): bool
    {
        $user = Auth::user();
        return ($user?->hasRole('tecnico') && !$user->hasRole('admin'))
            || session('perfil_ativo') === 'tecnico';
    }
}