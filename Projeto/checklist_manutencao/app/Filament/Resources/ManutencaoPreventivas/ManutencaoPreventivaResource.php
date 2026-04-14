<?php

namespace App\Filament\Resources\ManutencaoPreventivas;

use App\Filament\Resources\ManutencaoPreventivas\Pages\CreateManutencaoPreventiva;
use App\Filament\Resources\ManutencaoPreventivas\Pages\EditManutencaoPreventiva;
use App\Filament\Resources\ManutencaoPreventivas\Pages\ListManutencaoPreventivas;
use App\Filament\Resources\ManutencaoPreventivas\Pages\ViewManutencaoPreventiva;
use App\Filament\Resources\ManutencaoPreventivas\Schemas\ManutencaoPreventivaForm;
use App\Filament\Resources\ManutencaoPreventivas\Schemas\ManutencaoPreventivaInfolist;
use App\Filament\Resources\ManutencaoPreventivas\Tables\ManutencaoPreventivasTable;
use App\Models\ManutencaoPreventiva;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class ManutencaoPreventivaResource extends Resource
{
    protected static ?string $model = ManutencaoPreventiva::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'ManutencaoPreventiva';

    public static function form(Schema $schema): Schema
    {
        return ManutencaoPreventivaForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return ManutencaoPreventivaInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return ManutencaoPreventivasTable::configure($table);
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
            'index' => ListManutencaoPreventivas::route('/'),
            'create' => CreateManutencaoPreventiva::route('/create'),
            'view' => ViewManutencaoPreventiva::route('/{record}'),
            'edit' => EditManutencaoPreventiva::route('/{record}/edit'),
        ];
    }
}
