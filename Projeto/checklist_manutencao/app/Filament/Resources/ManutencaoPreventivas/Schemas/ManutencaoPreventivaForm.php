<?php

namespace App\Filament\Resources\ManutencaoPreventivas\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class ManutencaoPreventivaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('maquina_id')
                    ->required()
                    ->numeric(),
                DatePicker::make('data_ultima'),
                DatePicker::make('data_proxima'),
                Select::make('status')
                    ->options(['pendente' => 'Pendente', 'agendada' => 'Agendada', 'concluida' => 'Concluida'])
                    ->default('pendente')
                    ->required(),
            ]);
    }
}
