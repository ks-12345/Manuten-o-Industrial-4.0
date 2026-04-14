<?php

namespace App\Filament\Resources\Inspecaos\Schemas;

use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class InspecaoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('maquina_id')
                    ->required()
                    ->numeric(),
                TextInput::make('tecnico_id')
                    ->required()
                    ->numeric(),
                DateTimePicker::make('data_inspecao')
                    ->required(),
                Textarea::make('observacoes')
                    ->columnSpanFull(),
                Select::make('status')
                    ->options(['aprovado' => 'Aprovado', 'manutencao' => 'Manutencao'])
                    ->default('aprovado')
                    ->required(),
            ]);
    }
}
