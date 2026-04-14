<?php

namespace App\Filament\Resources\PrevisaoFalhas\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class PrevisaoFalhaInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('maquina_id')
                    ->numeric(),
                TextEntry::make('nivel_risco')
                    ->badge(),
                TextEntry::make('descricao')
                    ->placeholder('-')
                    ->columnSpanFull(),
                TextEntry::make('data_analise')
                    ->date(),
                TextEntry::make('created_at')
                    ->dateTime()
                    ->placeholder('-'),
                TextEntry::make('updated_at')
                    ->dateTime()
                    ->placeholder('-'),
            ]);
    }
}
