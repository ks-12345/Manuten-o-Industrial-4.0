<?php

namespace App\Filament\Resources\ManutencaoCorretivas\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class ManutencaoCorretivaInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('maquina_id')
                    ->numeric(),
                TextEntry::make('tecnico_id')
                    ->numeric(),
                TextEntry::make('tipo_falha'),
                TextEntry::make('gravidade')
                    ->badge(),
                TextEntry::make('status')
                    ->badge(),
                TextEntry::make('descricao')
                    ->placeholder('-')
                    ->columnSpanFull(),
                TextEntry::make('data_abertura')
                    ->dateTime(),
                TextEntry::make('data_fechamento')
                    ->dateTime()
                    ->placeholder('-'),
                TextEntry::make('created_at')
                    ->dateTime()
                    ->placeholder('-'),
                TextEntry::make('updated_at')
                    ->dateTime()
                    ->placeholder('-'),
            ]);
    }
}
