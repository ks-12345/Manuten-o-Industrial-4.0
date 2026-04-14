<?php

namespace App\Filament\Resources\TrocaPecas;

use App\Filament\Resources\TrocaPecas\Pages\CreateTrocaPeca;
use App\Filament\Resources\TrocaPecas\Pages\EditTrocaPeca;
use App\Filament\Resources\TrocaPecas\Pages\ListTrocaPecas;
use App\Filament\Resources\TrocaPecas\Pages\ViewTrocaPeca;
use App\Filament\Resources\TrocaPecas\Schemas\TrocaPecaForm;
use App\Filament\Resources\TrocaPecas\Schemas\TrocaPecaInfolist;
use App\Filament\Resources\TrocaPecas\Tables\TrocaPecasTable;
use App\Models\TrocaPeca;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class TrocaPecaResource extends Resource
{
    protected static ?string $model = TrocaPeca::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'TrocaPeca';

    public static function form(Schema $schema): Schema
    {
        return TrocaPecaForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return TrocaPecaInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return TrocaPecasTable::configure($table);
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
            'index' => ListTrocaPecas::route('/'),
            'create' => CreateTrocaPeca::route('/create'),
            'view' => ViewTrocaPeca::route('/{record}'),
            'edit' => EditTrocaPeca::route('/{record}/edit'),
        ];
    }
}
