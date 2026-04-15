<?php

namespace App\Filament\Resources\Inspecaos\RelationManagers;

use Filament\Actions\AssociateAction;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\CreateAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\DissociateAction;
use Filament\Actions\DissociateBulkAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\Select;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Schemas\Schema;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class ItensRelationManager extends RelationManager
{
    protected static string $relationship = 'itens';

    public function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('item')
                    ->options([
            'lubrificacao' => 'Lubrificacao',
            'temperatura' => 'Temperatura',
            'ruido' => 'Ruido',
            'limpeza' => 'Limpeza',
            'pecas' => 'Pecas',
        ])
                    ->required(),
                Select::make('status')
                    ->options(['ok' => 'Ok', 'problema' => 'Problema'])
                    ->default('ok')
                    ->required(),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('item')
            ->columns([
                TextColumn::make('item')
                    ->badge(),
                TextColumn::make('status')
                    ->badge(),
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
            ->headerActions([
                CreateAction::make(),
                AssociateAction::make(),
            ])
            ->recordActions([
                EditAction::make(),
                DissociateAction::make(),
                DeleteAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DissociateBulkAction::make(),
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
