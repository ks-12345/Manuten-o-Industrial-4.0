<?php

namespace App\Filament\Resources\TrocaPecas\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class TrocaPecaInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('maquina_id')
                    ->numeric(),
                TextEntry::make('peca_id')
                    ->numeric(),
                TextEntry::make('data_troca')
                    ->date(),
                TextEntry::make('observacoes')
                    ->placeholder('-')
                    ->columnSpanFull(),
                TextEntry::make('created_at')
                    ->dateTime()
                    ->placeholder('-'),
                TextEntry::make('updated_at')
                    ->dateTime()
                    ->placeholder('-'),
            ]);
    }
}
