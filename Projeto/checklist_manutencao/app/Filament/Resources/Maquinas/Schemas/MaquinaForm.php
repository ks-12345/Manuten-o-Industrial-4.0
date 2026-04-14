<?php

namespace App\Filament\Resources\Maquinas\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class MaquinaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nome')
                    ->required(),
                TextInput::make('codigo')
                    ->required(),
                TextInput::make('localizacao_id')
                    ->numeric(),
                Select::make('status')
                    ->options([
            'funcionando' => 'Funcionando',
            'quebrada' => 'Quebrada',
            'manutencao' => 'Manutencao',
            'risco' => 'Risco',
        ])
                    ->default('funcionando')
                    ->required(),
                DatePicker::make('data_aquisicao'),
                Textarea::make('descricao')
                    ->columnSpanFull(),
            ]);
    }
}
