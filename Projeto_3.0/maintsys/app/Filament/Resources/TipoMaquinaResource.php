<?php

namespace App\Filament\Resources;

use App\Filament\Resources\TipoMaquinaResource\Pages;
use App\Models\TipoMaquina;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class TipoMaquinaResource extends Resource
{
    protected static ?string $model = TipoMaquina::class;
    protected static ?string $navigationIcon = 'heroicon-o-cog-6-tooth';
    protected static ?string $navigationGroup = 'Configurações';
    protected static ?string $navigationLabel = 'Tipos de Máquina';
    protected static ?string $modelLabel = 'Tipo de Máquina';
    protected static ?int $navigationSort = 2;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('checklists.view') ?? false;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Tipo de Máquina')
                ->columns(2)
                ->schema([
                    Forms\Components\TextInput::make('nome')
                        ->required()
                        ->unique(ignoreRecord: true)
                        ->maxLength(150),

                    Forms\Components\Toggle::make('ativo')
                        ->default(true)
                        ->inline(false),

                    Forms\Components\Textarea::make('descricao')
                        ->label('Descrição')
                        ->rows(3)
                        ->columnSpanFull(),
                ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('nome')->searchable()->sortable(),
                Tables\Columns\TextColumn::make('maquinas_count')->label('Máquinas')->counts('maquinas')->badge(),
                Tables\Columns\IconColumn::make('ativo')->boolean(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListTipoMaquinas::route('/'),
            'create' => Pages\CreateTipoMaquina::route('/create'),
            'edit' => Pages\EditTipoMaquina::route('/{record}/edit'),
        ];
    }
}
