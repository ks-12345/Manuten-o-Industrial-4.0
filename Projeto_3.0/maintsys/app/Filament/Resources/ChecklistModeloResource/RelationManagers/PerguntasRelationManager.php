<?php

namespace App\Filament\Resources\ChecklistModeloResource\RelationManagers;

use App\Enums\TipoResposta;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class PerguntasRelationManager extends RelationManager
{
    protected static string  $relationship = 'perguntas';
    protected static ?string $title        = 'Perguntas do Checklist';

    public function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\TextInput::make('pergunta')
                ->label('Pergunta')
                ->required()
                ->columnSpanFull(),

            Forms\Components\Select::make('tipo_resposta')
                ->label('Tipo de Resposta')
                ->options(TipoResposta::options())
                ->required(),

            Forms\Components\TextInput::make('ordem')
                ->label('Ordem')
                ->numeric()
                ->default(0),

            Forms\Components\Toggle::make('obrigatoria')
                ->label('Obrigatória')
                ->default(true)
                ->inline(false),

            Forms\Components\Textarea::make('ajuda')
                ->label('Texto de Ajuda')
                ->rows(2)
                ->columnSpanFull()
                ->nullable(),
        ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('pergunta')
            ->reorderable('ordem')
            ->columns([
                Tables\Columns\TextColumn::make('ordem')->label('#')->sortable(),
                Tables\Columns\TextColumn::make('pergunta')->label('Pergunta')->wrap(),
                Tables\Columns\TextColumn::make('tipo_resposta')
                    ->label('Tipo')
                    ->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())
                    ->color('info'),
                Tables\Columns\IconColumn::make('obrigatoria')->label('Obrigatória')->boolean(),
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make()->label('Nova Pergunta'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ]);
    }
}