<?php

namespace App\Filament\Resources\Maquinas\RelationManagers;

use Filament\Actions\AssociateAction;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\CreateAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\DissociateAction;
use Filament\Actions\DissociateBulkAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Schemas\Schema;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class InspecoesRelationManager extends RelationManager
{
    protected static string $relationship = 'inspecoes';

    public function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('tecnico_id')
                    ->required()
                    ->numeric(),
                DateTimePicker::make('data_inspecao')
                    ->required(),
                Textarea::make('observacoes')
                    ->columnSpanFull(),
                Select::make('status')
                    ->options(['aprovado' => 'Aprovado', 'manutencao' => 'Manutencao'])
                    ->default('aprovado')
                    ->required(),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('data_inspecao')
            ->columns([
                TextColumn::make('tecnico_id')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('data_inspecao')
                    ->dateTime()
                    ->sortable(),
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
