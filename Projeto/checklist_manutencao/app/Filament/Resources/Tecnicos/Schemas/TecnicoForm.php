<?php

namespace App\Filament\Resources\Tecnicos\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class TecnicoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nome')
                    ->required(),
                TextInput::make('email')
                    ->label('Email address')
                    ->email()
                    ->required(),
                Select::make('tipo')
                    ->options(['aluno' => 'Aluno', 'tecnico' => 'Tecnico', 'admin' => 'Admin'])
                    ->default('aluno')
                    ->required(),
            ]);
    }
}
