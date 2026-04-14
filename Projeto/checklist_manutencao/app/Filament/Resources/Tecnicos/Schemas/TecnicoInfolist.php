<?php

namespace App\Filament\Resources\Tecnicos\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class TecnicoInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('nome'),
                TextEntry::make('email')
                    ->label('Email address'),
                TextEntry::make('tipo')
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
