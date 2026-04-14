<?php

namespace App\Filament\Resources\Localizacaos\Schemas;

use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class LocalizacaoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nome')
                    ->required(),
                TextInput::make('pos_x')
                    ->required()
                    ->numeric()
                    ->default(0),
                TextInput::make('pos_y')
                    ->required()
                    ->numeric()
                    ->default(0),
            ]);
    }
}
