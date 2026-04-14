<?php

namespace App\Filament\Resources\ManutencaoCorretivas\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class ManutencaoCorretivasTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('maquina_id')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('tecnico_id')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('tipo_falha')
                    ->searchable(),
                TextColumn::make('gravidade')
                    ->badge(),
                TextColumn::make('status')
                    ->badge(),
                TextColumn::make('data_abertura')
                    ->dateTime()
                    ->sortable(),
                TextColumn::make('data_fechamento')
                    ->dateTime()
                    ->sortable(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
