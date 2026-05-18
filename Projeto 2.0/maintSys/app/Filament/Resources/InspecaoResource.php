<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InspecaoResource\Pages;
use App\Filament\Resources\InspecaoResource\RelationManagers;
use App\Models\Inspecao;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class InspecaoResource extends Resource
{
    protected static ?string $model = Inspecao::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
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
            'index' => Pages\ListInspecaos::route('/'),
            'create' => Pages\CreateInspecao::route('/create'),
            'edit' => Pages\EditInspecao::route('/{record}/edit'),
        ];
    }
}
