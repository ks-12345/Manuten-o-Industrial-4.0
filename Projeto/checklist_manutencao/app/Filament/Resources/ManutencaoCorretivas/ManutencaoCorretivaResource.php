<?php

namespace App\Filament\Resources\ManutencaoCorretivas;

use App\Filament\Resources\ManutencaoCorretivas\Pages\CreateManutencaoCorretiva;
use App\Filament\Resources\ManutencaoCorretivas\Pages\EditManutencaoCorretiva;
use App\Filament\Resources\ManutencaoCorretivas\Pages\ListManutencaoCorretivas;
use App\Filament\Resources\ManutencaoCorretivas\Pages\ViewManutencaoCorretiva;
use App\Filament\Resources\ManutencaoCorretivas\Schemas\ManutencaoCorretivaForm;
use App\Filament\Resources\ManutencaoCorretivas\Schemas\ManutencaoCorretivaInfolist;
use App\Filament\Resources\ManutencaoCorretivas\Tables\ManutencaoCorretivasTable;
use App\Models\ManutencaoCorretiva;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class ManutencaoCorretivaResource extends Resource
{
    protected static ?string $model = ManutencaoCorretiva::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'ManutencaoCorretiva';

    public static function form(Schema $schema): Schema
    {
        return ManutencaoCorretivaForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return ManutencaoCorretivaInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return ManutencaoCorretivasTable::configure($table);
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
            'index' => ListManutencaoCorretivas::route('/'),
            'create' => CreateManutencaoCorretiva::route('/create'),
            'view' => ViewManutencaoCorretiva::route('/{record}'),
            'edit' => EditManutencaoCorretiva::route('/{record}/edit'),
        ];
    }
}
