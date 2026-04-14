<?php

namespace App\Filament\Resources\ManutencaoPreventivas\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class ManutencaoPreventivaInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('maquina_id')
                    ->numeric(),
                TextEntry::make('data_ultima')
                    ->date()
                    ->placeholder('-'),
                TextEntry::make('data_proxima')
                    ->date()
                    ->placeholder('-'),
                TextEntry::make('status')
                    ->badge(),
                TextEntry::make('created_at')
                    ->dateTime()
                    ->placeholder('-'),
                TextEntry::make('updated_at')
                    ->dateTime()
                    ->placeholder('-'),
            ]);
    }
}
