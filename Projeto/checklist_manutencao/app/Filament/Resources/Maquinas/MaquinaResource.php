<?php

namespace App\Filament\Resources\Maquinas;

use App\Filament\Resources\Maquinas\Pages\CreateMaquina;
use App\Filament\Resources\Maquinas\Pages\EditMaquina;
use App\Filament\Resources\Maquinas\Pages\ListMaquinas;
use App\Filament\Resources\Maquinas\Pages\ViewMaquina;
use App\Filament\Resources\Maquinas\Schemas\MaquinaForm;
use App\Filament\Resources\Maquinas\Schemas\MaquinaInfolist;
use App\Filament\Resources\Maquinas\Tables\MaquinasTable;
use App\Models\Maquina;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Support\Icons\Heroicon;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Forms\Components\{Select, TextInput, DatePicker, Textarea};
use Filament\Schemas\Schema;
use Filament\Tables\Columns\{TextColumn, BadgeColumn};
use Filament\Tables\Filters\SelectFilter;


class MaquinaResource extends Resource
{
    public static function form(Schema $schema):Schema{
    return $schema->components([
        TextInput::make('nome')->required()->maxLength(255),
        TextInput::make('codigo')->required()->unique(ignoreRecord: true),
        Select::make('localizacao_id')
            ->label('Localização')
            ->relationship('localizacao', 'nome')
            ->searchable()
            ->preload(),
        Select::make('status')
            ->options([
                'funcionando' => 'Funcionando',
                'quebrada'    => 'Quebrada',
                'manutencao'  => 'Em Manutenção',
                'risco'       => 'Risco de Falha',
            ])->required(),
        DatePicker::make('data_aquisicao')->label('Data de Aquisição'),
        Textarea::make('descricao')->label('Descrição')->columnSpanFull(),
    ]);
}

// No método table():
public static function table(Table $table): Table
{
    return $table
        ->columns([
            TextColumn::make('nome')->searchable()->sortable(),
            TextColumn::make('codigo')->searchable(),
            TextColumn::make('localizacao.nome')->label('Localização'),
            TextColumn::make('status')
                ->badge()
                ->color(fn (string $state): string => match ($state) {
                    'funcionando' => 'success',
                    'quebrada'    => 'danger',
                    'manutencao'  => 'warning',
                    'risco'       => 'danger',
                }),
            TextColumn::make('data_aquisicao')->date()->sortable(),
        ])
        ->filters([
            SelectFilter::make('status')->options([
                'funcionando' => 'Funcionando',
                'quebrada'    => 'Quebrada',
                'manutencao'  => 'Em Manutenção',
                'risco'       => 'Risco',
            ]),
        ]);
}
}
