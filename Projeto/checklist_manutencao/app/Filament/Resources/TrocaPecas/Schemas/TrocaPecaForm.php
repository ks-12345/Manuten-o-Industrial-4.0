<?php

namespace App\Filament\Resources\TrocaPecas\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class TrocaPecaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('maquina_id')
                    ->required()
                    ->numeric(),
                TextInput::make('peca_id')
                    ->required()
                    ->numeric(),
                DatePicker::make('data_troca')
                    ->required(),
                Textarea::make('observacoes')
                    ->columnSpanFull(),
            ]);
    }
}
