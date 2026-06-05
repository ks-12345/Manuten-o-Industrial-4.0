<?php

namespace App\Filament\Resources;

use App\Filament\Resources\SetorResource\Pages;
use App\Filament\Resources\SetorResource\RelationManagers\MaquinasRelationManager;
use App\Models\Setor;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class SetorResource extends Resource
{
    protected static ?string $model           = Setor::class;
    protected static ?string $navigationIcon  = 'heroicon-o-building-office';
    protected static ?string $navigationGroup = 'Cadastros';
    protected static ?string $navigationLabel = 'Setores';
    protected static ?string $modelLabel      = 'Setor';
    protected static ?int    $navigationSort  = 2;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('setores.view') ?? false;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make()->columns(2)->schema([
                Forms\Components\TextInput::make('nome')
                    ->label('Nome do Setor')
                    ->required()
                    ->maxLength(100),

                Forms\Components\TextInput::make('codigo')
                    ->label('Código')
                    ->required()
                    ->unique(ignoreRecord: true)
                    ->maxLength(20)
                    ->placeholder('EX: PROD-01'),

                Forms\Components\Select::make('responsavel_id')
                    ->label('Responsável')
                    ->options(User::ativos()->pluck('name', 'id'))
                    ->searchable()
                    ->nullable(),

                Forms\Components\TextInput::make('localizacao')
                    ->label('Localização')
                    ->maxLength(100)
                    ->placeholder('Ex: Galpão A, Bloco B'),

                Forms\Components\Textarea::make('descricao')
                    ->label('Descrição')
                    ->columnSpanFull()
                    ->rows(3),

                Forms\Components\Toggle::make('ativo')
                    ->label('Setor Ativo')
                    ->default(true)
                    ->inline(false),
            ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('codigo')
                    ->label('Código')
                    ->searchable()
                    ->sortable()
                    ->badge()
                    ->color('gray'),

                Tables\Columns\TextColumn::make('nome')
                    ->label('Setor')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('responsavel.name')
                    ->label('Responsável')
                    ->placeholder('—'),

                Tables\Columns\TextColumn::make('localizacao')
                    ->label('Localização')
                    ->placeholder('—'),

                Tables\Columns\TextColumn::make('maquinas_count')
                    ->label('Máquinas')
                    ->counts('maquinas')
                    ->badge()
                    ->color('info'),

                Tables\Columns\IconColumn::make('ativo')
                    ->label('Ativo')
                    ->boolean(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Criado em')
                    ->dateTime('d/m/Y')
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\TernaryFilter::make('ativo')
                    ->label('Status'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make()
                    ->before(function ($record) {
                        if ($record->maquinas()->exists()) {
                            \Filament\Notifications\Notification::make()
                                ->danger()
                                ->title('Não é possível excluir um setor com máquinas cadastradas.')
                                ->send();

                            return false;
                        }
                    }),
            ]);
    }

    public static function getRelationManagers(): array
    {
        return [
            // MaquinasRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListSetors::route('/'),
            'create' => Pages\CreateSetor::route('/create'),
            'edit'   => Pages\EditSetor::route('/{record}/edit'),
        ];
    }
}