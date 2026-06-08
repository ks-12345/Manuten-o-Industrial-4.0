<?php

namespace App\Filament\Widgets;

use App\Enums\StatusOcorrencia;
use App\Models\Ocorrencia;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\Auth;

class StatsProfessorWidget extends BaseWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $userId = Auth::id();

        return [
            Stat::make('Minhas Ocorrências', Ocorrencia::where('professor_id', $userId)->count())
                ->description('Total registradas')
                ->descriptionIcon('heroicon-o-document-text')
                ->color('primary'),

            Stat::make('Em Aberto', Ocorrencia::where('professor_id', $userId)->where('status', 'aberta')->count())
                ->description('Aguardando técnico')
                ->descriptionIcon('heroicon-o-clock')
                ->color('warning'),

            Stat::make('Em Andamento', Ocorrencia::where('professor_id', $userId)
                ->whereIn('status', [
                    StatusOcorrencia::Assumida->value,
                    StatusOcorrencia::EmInspecao->value,
                    StatusOcorrencia::AguardandoOrcamento->value,
                    StatusOcorrencia::Corretiva->value,
                ])
                ->count())
                ->description('Em tratamento')
                ->descriptionIcon('heroicon-o-arrow-path')
                ->color('info'),

            Stat::make('Finalizadas', Ocorrencia::where('professor_id', $userId)->where('status', StatusOcorrencia::Concluida->value)->count())
                ->description('Resolvidas')
                ->descriptionIcon('heroicon-o-check-circle')
                ->color('success'),
        ];
    }

    public static function canView(): bool
    {
        $user = Auth::user();
        return ($user?->hasRole('professor') && !$user->hasRole('admin'))
            || session('perfil_ativo') === 'professor';
    }
}
