<?php

namespace App\Filament\Resources;

use App\Enums\TipoChecklist;
use App\Enums\TipoResposta;
use App\Filament\Resources\ChecklistModeloResource\Pages;
use App\Filament\Resources\ChecklistModeloResource\RelationManagers\PerguntasRelationManager;
use App\Models\ChecklistModelo;
use App\Models\Maquina;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class ChecklistModeloResource extends Resource
{
    protected static ?string $model           = ChecklistModelo::class;
    protected static ?string $navigationIcon  = 'heroicon-o-clipboard-document-check';
    protected static ?string $navigationGroup = 'Configurações';
    protected static ?string $navigationLabel = 'Checklists';
    protected static ?string $modelLabel      = 'Modelo de Checklist';
    protected static ?int    $navigationSort  = 3;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('checklists.view') ?? false;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make()->columns(2)->schema([
                Forms\Components\TextInput::make('nome')
                    ->label('Nome do Checklist')
                    ->required()
                    ->maxLength(150),

                Forms\Components\Select::make('tipo')
                    ->label('Tipo')
                    ->options(TipoChecklist::options())
                    ->required(),

                Forms\Components\Select::make('maquina_id')
                    ->label('Máquina Específica (opcional)')
                    ->options(Maquina::pluck('nome', 'id'))
                    ->searchable()
                    ->nullable()
                    ->helperText('Deixe em branco para checklist global.'),

                Forms\Components\Toggle::make('ativo')
                    ->label('Ativo')
                    ->default(true)
                    ->inline(false),

                Forms\Components\Textarea::make('descricao')
                    ->label('Descrição')
                    ->columnSpanFull()
                    ->rows(3),
            ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('nome')
                    ->label('Nome')
                    ->searchable(),

                Tables\Columns\TextColumn::make('tipo')
                    ->label('Tipo')
                    ->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())
                    ->color('primary'),

                Tables\Columns\TextColumn::make('maquina.nome')
                    ->label('Máquina')
                    ->placeholder('Global'),

                Tables\Columns\TextColumn::make('perguntas_count')
                    ->label('Perguntas')
                    ->counts('perguntas')
                    ->badge()
                    ->color('info'),

                Tables\Columns\IconColumn::make('ativo')
                    ->label('Ativo')
                    ->boolean(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ]);
    }

    public static function getRelationManagers(): array
    {
        return [PerguntasRelationManager::class];
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListChecklistModelos::route('/'),
            'create' => Pages\CreateChecklistModelo::route('/create'),
            'edit'   => Pages\EditChecklistModelo::route('/{record}/edit'),
        ];
    }
}