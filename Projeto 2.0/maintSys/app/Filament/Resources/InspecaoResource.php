<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InspecaoResource\Pages;
use App\Models\Inspecao;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

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
                Tables\Actions\Action::make('executar')
                    ->label('Executar')
                    ->icon('heroicon-o-clipboard-document-check')
                    ->color('warning')
                    ->url(fn (Inspecao $record): string => static::getUrl('executar', ['record' => $record])),
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
            'executar' => Pages\Executar::route('/{record}/executar'),
            'edit' => Pages\EditInspecao::route('/{record}/edit'),
        ];
    }
}
