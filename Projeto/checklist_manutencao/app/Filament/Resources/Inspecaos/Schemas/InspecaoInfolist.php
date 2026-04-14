<?php

namespace App\Filament\Resources\Inspecaos\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class InspecaoInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('maquina_id')
                    ->numeric(),
                TextEntry::make('tecnico_id')
                    ->numeric(),
                TextEntry::make('data_inspecao')
                    ->dateTime(),
                TextEntry::make('observacoes')
                    ->placeholder('-')
                    ->columnSpanFull(),
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
