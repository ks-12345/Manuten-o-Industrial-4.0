<?php

namespace App\Filament\Resources\PrevisaoFalhas\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class PrevisaoFalhaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('maquina_id')
                    ->required()
                    ->numeric(),
                Select::make('nivel_risco')
                    ->options(['baixo' => 'Baixo', 'medio' => 'Medio', 'alto' => 'Alto'])
                    ->default('baixo')
                    ->required(),
                Textarea::make('descricao')
                    ->columnSpanFull(),
                DatePicker::make('data_analise')
                    ->required(),
            ]);
    }
}
