<?php

namespace App\Filament\Resources\OcorrenciaResource\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class HistoricoRelationManager extends RelationManager
{
    protected static string  $relationship = 'historicos';
    protected static ?string $title        = 'Histórico de Atividades';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Data/Hora')
                    ->dateTime('d/m/Y H:i:s')
                    ->sortable(),
                Tables\Columns\TextColumn::make('user.name')->label('Usuário')->placeholder('Sistema'),
                Tables\Columns\TextColumn::make('acao')
                    ->label('Ação')
                    ->badge()
                    ->color('primary'),
                Tables\Columns\TextColumn::make('descricao')
                    ->label('Descrição')
                    ->wrap(),
            ])
            ->defaultSort('created_at', 'desc')
            ->allowDuplicates();
    }
}