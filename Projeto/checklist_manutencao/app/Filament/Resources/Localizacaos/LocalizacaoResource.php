<?php

namespace App\Filament\Resources\Localizacaos;

use App\Filament\Resources\Localizacaos\Pages\CreateLocalizacao;
use App\Filament\Resources\Localizacaos\Pages\EditLocalizacao;
use App\Filament\Resources\Localizacaos\Pages\ListLocalizacaos;
use App\Filament\Resources\Localizacaos\Pages\ViewLocalizacao;
use App\Filament\Resources\Localizacaos\Schemas\LocalizacaoForm;
use App\Filament\Resources\Localizacaos\Schemas\LocalizacaoInfolist;
use App\Filament\Resources\Localizacaos\Tables\LocalizacaosTable;
use App\Models\Localizacao;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class LocalizacaoResource extends Resource
{
    protected static ?string $model = Localizacao::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'Localizacao';

    public static function form(Schema $schema): Schema
    {
        return LocalizacaoForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return LocalizacaoInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return LocalizacaosTable::configure($table);
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
            'index' => ListLocalizacaos::route('/'),
            'create' => CreateLocalizacao::route('/create'),
            'view' => ViewLocalizacao::route('/{record}'),
            'edit' => EditLocalizacao::route('/{record}/edit'),
        ];
    }
}
