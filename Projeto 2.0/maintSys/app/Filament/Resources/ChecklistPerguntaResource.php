<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ChecklistPerguntaResource\Pages;
use App\Filament\Resources\ChecklistPerguntaResource\RelationManagers;
use App\Models\ChecklistPergunta;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ChecklistPerguntaResource extends Resource
{
    protected static ?string $model = ChecklistPergunta::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
{
    return $form
        ->schema([

            Forms\Components\Select::make('checklist_modelo_id')
                ->label('Checklist Modelo')
                ->relationship('checklistModelo', 'nome')
                ->searchable()
                ->required(),

            Forms\Components\Textarea::make('pergunta')
                ->label('Pergunta')
                ->required(),

            Forms\Components\TextInput::make('ordem')
                ->numeric()
                ->default(1),
        ]);
}

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                //
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListChecklistPerguntas::route('/'),
            'create' => Pages\CreateChecklistPergunta::route('/create'),
            'edit' => Pages\EditChecklistPergunta::route('/{record}/edit'),
        ];
    }
}
