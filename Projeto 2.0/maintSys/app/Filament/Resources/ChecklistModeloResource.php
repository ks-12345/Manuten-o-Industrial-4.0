<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ChecklistModeloResource\Pages;
use App\Filament\Resources\ChecklistModeloResource\RelationManagers;
use App\Models\ChecklistModelo;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ChecklistModeloResource extends Resource
{
    protected static ?string $model = ChecklistModelo::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

public static function form(Form $form): Form
{
    return $form
        ->schema([
            Forms\Components\Select::make('maquina_id')
                ->label('Máquina')
                ->relationship('maquina', 'nome')
                ->required(),

            Forms\Components\TextInput::make('nome')
                ->required(),

            Forms\Components\Select::make('tipo')
                ->label('Tipo de Checklist')
                ->options([
                    'preventiva' => 'Preventiva',
                    'corretiva' => 'Corretiva',
                    'inspecao' => 'Inspeção',
                ])
                ->required(),
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
            'index' => Pages\ListChecklistModelos::route('/'),
            'create' => Pages\CreateChecklistModelo::route('/create'),
            'edit' => Pages\EditChecklistModelo::route('/{record}/edit'),
        ];
    }
}
