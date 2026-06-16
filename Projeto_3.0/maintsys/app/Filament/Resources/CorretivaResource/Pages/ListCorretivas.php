<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use App\Models\Corretiva;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Filament\Resources\Components\Tab;
use Illuminate\Support\Facades\Auth;

class ListCorretivas extends ListRecords
{
    protected static string $resource = CorretivaResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }

    public function getTabs(): array
    {
        $user = Auth::user();

        $pendentesCount = Corretiva::where('status', 'pendente')
            ->whereNull('tecnico_id')
            ->count();

        $andamentoCount = Corretiva::where('status', 'em_andamento')
            ->when(! $user->hasRole('admin'), fn ($q) => $q->where('tecnico_id', $user->id))
            ->count();

        $tabs = [
            'pendentes' => Tab::make('Pendentes')
                ->icon('heroicon-o-clock')
                ->badge($pendentesCount ?: null)
                ->badgeColor('danger')
                ->modifyQueryUsing(fn ($query) =>
                    $query->where('status', 'pendente')->whereNull('tecnico_id')
                ),

            'em_andamento' => Tab::make('Em Andamento')
                ->icon('heroicon-o-play-circle')
                ->badge($andamentoCount ?: null)
                ->badgeColor('warning')
                ->modifyQueryUsing(fn ($query) =>
                    $query->where('status', 'em_andamento')
                ),

            'finalizadas' => Tab::make('Finalizadas')
                ->icon('heroicon-o-check-circle')
                ->modifyQueryUsing(fn ($query) =>
                    $query->where('status', 'finalizada')
                ),
        ];

        // Aba "Todas" só para admin — sem ->visible() (não existe no Tab)
        if ($user->hasRole('admin')) {
            $tabs['all'] = Tab::make('Todas')
                ->icon('heroicon-o-list-bullet');
        }

        return $tabs;
    }

    public function getDefaultActiveTab(): string | int | null
    {
        return 'pendentes';
    }
}