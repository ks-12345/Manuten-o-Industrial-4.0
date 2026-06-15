<?php

namespace App\Filament\Resources\CorretivaResource\Pages;

use App\Filament\Resources\CorretivaResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Filament\Resources\Components\Tab;

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
        return [
            'pendentes' => Tab::make('Pendentes / Sem Responsável')
                ->badge(\App\Models\Corretiva::where('status', 'pendente')->count())
                ->badgeColor('danger')
                ->modifyQueryUsing(fn ($query) => $query->where('status', 'pendente')),

            'em_andamento' => Tab::make('Em Andamento')
                ->modifyQueryUsing(fn ($query) => $query->where('status', 'em_andamento')),

            'finalizadas' => Tab::make('Finalizadas')
                ->modifyQueryUsing(fn ($query) => $query->where('status', 'finalizada')),

            'all' => Tab::make('Todas'),
        ];
    }
}