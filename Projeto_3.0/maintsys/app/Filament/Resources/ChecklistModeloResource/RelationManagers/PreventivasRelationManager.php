<?php

namespace App\Filament\Resources\MaquinaResource\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class PreventivasRelationManager extends RelationManager
{
    protected static string  $relationship = 'preventivas';
    protected static ?string $title        = 'Preventivas';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('periodicidade')->label('Periodicidade')
                    ->formatStateUsing(fn($s) => $s->getLabel())->badge()->color('info'),
                Tables\Columns\TextColumn::make('data_prevista')->label('Data Prevista')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('status')->label('Status')->badge()
                    ->color(fn($s) => match($s) {
                        'realizada' => 'success', 'atrasada' => 'danger', default => 'warning',
                    }),
                Tables\Columns\TextColumn::make('tecnico.name')->label('Técnico')->placeholder('—'),
            ])
            ->defaultSort('data_prevista', 'asc');
    }
}