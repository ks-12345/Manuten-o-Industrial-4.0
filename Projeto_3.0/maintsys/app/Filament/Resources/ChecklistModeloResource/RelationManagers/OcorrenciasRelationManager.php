<?php

namespace App\Filament\Resources\MaquinaResource\RelationManagers;

use App\Enums\StatusOcorrencia;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class OcorrenciasRelationManager extends RelationManager
{
    protected static string  $relationship = 'ocorrencias';
    protected static ?string $title        = 'Ocorrências';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('codigo')->label('Código')->badge()->color('primary'),
                Tables\Columns\TextColumn::make('titulo')->label('Título')->limit(40),
                Tables\Columns\TextColumn::make('professor.name')->label('Professor'),
                Tables\Columns\TextColumn::make('prioridade')->label('Prioridade')->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())->color(fn($s) => $s->getColor()),
                Tables\Columns\TextColumn::make('status')->label('Status')->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())->color(fn($s) => $s->getColor()),
                Tables\Columns\TextColumn::make('created_at')->label('Data')->dateTime('d/m/Y'),
            ])
            ->defaultSort('created_at', 'desc');
    }
}