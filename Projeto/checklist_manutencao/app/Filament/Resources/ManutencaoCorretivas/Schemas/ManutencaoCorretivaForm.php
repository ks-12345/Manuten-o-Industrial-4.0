<?php

namespace App\Filament\Resources\ManutencaoCorretivas\Schemas;

use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class ManutencaoCorretivaForm
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
                TextInput::make('tipo_falha')
                    ->required(),
                Select::make('gravidade')
                    ->options(['baixa' => 'Baixa', 'media' => 'Media', 'alta' => 'Alta'])
                    ->default('media')
                    ->required(),
                Select::make('status')
                    ->options(['aberto' => 'Aberto', 'andamento' => 'Andamento', 'concluido' => 'Concluido'])
                    ->default('aberto')
                    ->required(),
                Textarea::make('descricao')
                    ->columnSpanFull(),
                DateTimePicker::make('data_abertura')
                    ->required(),
                DateTimePicker::make('data_fechamento'),
            ]);
    }
}
