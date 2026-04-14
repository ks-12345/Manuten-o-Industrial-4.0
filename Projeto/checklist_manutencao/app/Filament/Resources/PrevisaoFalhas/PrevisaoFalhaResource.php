<?php

namespace App\Filament\Resources\PrevisaoFalhas;

use App\Filament\Resources\PrevisaoFalhas\Pages\CreatePrevisaoFalha;
use App\Filament\Resources\PrevisaoFalhas\Pages\EditPrevisaoFalha;
use App\Filament\Resources\PrevisaoFalhas\Pages\ListPrevisaoFalhas;
use App\Filament\Resources\PrevisaoFalhas\Pages\ViewPrevisaoFalha;
use App\Filament\Resources\PrevisaoFalhas\Schemas\PrevisaoFalhaForm;
use App\Filament\Resources\PrevisaoFalhas\Schemas\PrevisaoFalhaInfolist;
use App\Filament\Resources\PrevisaoFalhas\Tables\PrevisaoFalhasTable;
use App\Models\PrevisaoFalha;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class PrevisaoFalhaResource extends Resource
{
    protected static ?string $model = PrevisaoFalha::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'PrevisaoFalha';

    public static function form(Schema $schema): Schema
    {
        return PrevisaoFalhaForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return PrevisaoFalhaInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PrevisaoFalhasTable::configure($table);
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
            'index' => ListPrevisaoFalhas::route('/'),
            'create' => CreatePrevisaoFalha::route('/create'),
            'view' => ViewPrevisaoFalha::route('/{record}'),
            'edit' => EditPrevisaoFalha::route('/{record}/edit'),
        ];
    }
}
