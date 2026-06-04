<?php

namespace App\Filament\Widgets;

use App\Models\Preventiva;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class PreventivasPendentesWidget extends BaseWidget
{
    protected static ?string $heading    = 'Próximas Preventivas';
    protected static ?int    $sort       = 3;
    protected int | string | array $columnSpan = 'full';

    public static function canView(): bool
    {
        return auth()->user()?->hasPermissionTo('preventivas.view') ?? false;
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
                Tables\Columns\TextColumn::make('maquina.nome')->label('Máquina')
                    ->description(fn($r) => $r->maquina?->setor?->nome),
                Tables\Columns\TextColumn::make('periodicidade')->label('Periodicidade')
                    ->formatStateUsing(fn($s) => $s->getLabel())->badge()->color('info'),
                Tables\Columns\TextColumn::make('data_prevista')->label('Data Prevista')
                    ->date('d/m/Y')
                    ->color(fn($r) => $r->estaAtrasada() ? 'danger' : null),
                Tables\Columns\TextColumn::make('status')->label('Status')->badge()
                    ->color(fn($s) => match($s) {
                        'atrasada'     => 'danger',
                        'em_andamento' => 'info',
                        default        => 'warning',
                    }),
                Tables\Columns\TextColumn::make('tecnico.name')->label('Técnico')->placeholder('Não atribuído'),
            ])
            ->paginated([5, 10]);
    }
}