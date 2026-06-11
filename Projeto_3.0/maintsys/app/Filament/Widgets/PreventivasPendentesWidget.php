<?php

namespace App\Filament\Widgets;

use App\Models\Preventiva;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use Illuminate\Support\Facades\Auth;

class PreventivasPendentesWidget extends BaseWidget
{
    protected static ?string $heading    = 'Próximas Preventivas';
protected static ?string $pollingInterval = '60s';

    protected static bool $isLazy = true;

    protected int | string | array $columnSpan = 'full';

    public static function canView(): bool
    {
        return Auth::user()?->hasPermissionTo('preventivas.view') ?? false;
    }

    public function table(Table $table): Table
    {
        return $table
            ->query(
                Preventiva::with(['maquina.setor', 'tecnico'])
                    ->whereIn('status', ['pendente', 'atrasada', 'em_andamento'])
                    ->orderBy('data_prevista')
            )
->columns([
    Tables\Columns\TextColumn::make('maquina.nome')
        ->label('Máquina')
        // Alterado de $r para $record
        ->description(fn($record) => $record->maquina?->setor?->nome),

    Tables\Columns\TextColumn::make('periodicidade')
        ->label('Periodicidade')
        // CORREÇÃO CRÍTICA: Alterado de $s para $state
        ->formatStateUsing(fn($state) => $state->getLabel()) 
        ->badge()
        ->color('info'),

    Tables\Columns\TextColumn::make('data_prevista')
        ->label('Data Prevista')
        ->date('d/m/Y')
        // Alterado de $r para $record
        ->color(fn($record) => $record->estaAtrasada() ? 'danger' : null),

    Tables\Columns\TextColumn::make('status')
        ->label('Status')
        ->badge()
        // CORREÇÃO CRÍTICA: Alterado de $s para $state
        ->color(fn($state) => match($state) {
            'atrasada'     => 'danger',
            'em_andamento' => 'info',
            default        => 'warning',
        }),

    Tables\Columns\TextColumn::make('tecnico.name')
        ->label('Técnico')
        ->placeholder('Não atribuído'),
])
            ->paginated([5, 10]);
    }
}