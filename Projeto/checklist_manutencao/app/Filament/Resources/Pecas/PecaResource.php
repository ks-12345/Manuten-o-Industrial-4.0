<?php

namespace App\Filament\Resources\Pecas;

use App\Filament\Resources\Pecas\Pages\CreatePeca;
use App\Filament\Resources\Pecas\Pages\EditPeca;
use App\Filament\Resources\Pecas\Pages\ListPecas;
use App\Filament\Resources\Pecas\Pages\ViewPeca;
use App\Filament\Resources\Pecas\Schemas\PecaForm;
use App\Filament\Resources\Pecas\Schemas\PecaInfolist;
use App\Filament\Resources\Pecas\Tables\PecasTable;
use App\Models\Peca;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class PecaResource extends Resource
{
    protected static ?string $model = Peca::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'Peca';

    public static function form(Schema $schema): Schema
    {
        return PecaForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return PecaInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PecasTable::configure($table);
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
            'index' => ListPecas::route('/'),
            'create' => CreatePeca::route('/create'),
            'view' => ViewPeca::route('/{record}'),
            'edit' => EditPeca::route('/{record}/edit'),
        ];
    }
}
