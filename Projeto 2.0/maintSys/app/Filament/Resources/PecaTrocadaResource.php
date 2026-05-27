<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PecaTrocadaResource\Pages;
use App\Filament\Resources\PecaTrocadaResource\RelationManagers;
use App\Models\PecaTrocada;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PecaTrocadaResource extends Resource
{
    protected static ?string $model = PecaTrocada::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
{
    return $form
        ->schema([

            Forms\Components\Select::make('corretiva_id')
                ->label('Ordem Corretiva')
                ->relationship('corretiva', 'id') // ou troque por "descricao" se existir
                ->searchable()
                ->required(),

            Forms\Components\TextInput::make('nome_peca')
                ->label('Peça')
                ->required(),

            Forms\Components\TextInput::make('quantidade')
                ->numeric()
                ->default(1)
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
            'index' => Pages\ListPecaTrocadas::route('/'),
            'create' => Pages\CreatePecaTrocada::route('/create'),
            'edit' => Pages\EditPecaTrocada::route('/{record}/edit'),
        ];
    }
}
