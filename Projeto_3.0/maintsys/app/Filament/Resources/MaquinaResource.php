<?php

namespace App\Filament\Resources;

use App\Enums\PeriodicidadePreventiva;
use App\Enums\StatusMaquina;
use App\Filament\Resources\MaquinaResource\Pages;
use App\Filament\Resources\MaquinaResource\RelationManagers\ChecklistModeloRelationManager;
use App\Filament\Resources\MaquinaResource\RelationManagers\OcorrenciasRelationManager;
use App\Filament\Resources\MaquinaResource\RelationManagers\PreventivasRelationManager;
use App\Models\Maquina;
use App\Models\Setor;
use App\Models\TipoMaquina;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class MaquinaResource extends Resource
{
    protected static ?string $model           = Maquina::class;
    protected static ?string $navigationIcon  = 'heroicon-o-cpu-chip';
    protected static ?string $navigationGroup = 'Cadastros';
    protected static ?string $navigationLabel = 'Máquinas';
    protected static ?string $modelLabel      = 'Máquina';
    protected static ?int    $navigationSort  = 3;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('maquinas.view') ?? false;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Identificação')
                ->icon('heroicon-o-identification')
                ->columns(3)
                ->schema([
                    Forms\Components\Select::make('setor_id')
                        ->label('Setor')
                        ->options(Setor::ativos()->pluck('nome', 'id'))
                        ->searchable()
                        ->required(),

                    Forms\Components\Select::make('tipo_maquina_id')
                        ->label('Tipo de Máquina')
                        ->options(TipoMaquina::ativos()->pluck('nome', 'id'))
                        ->searchable()
                        ->preload()
                        ->nullable(),

                    Forms\Components\TextInput::make('nome')
                        ->label('Nome da Máquina')
                        ->required()
                        ->maxLength(150)
                        ->columnSpan(1),

                    Forms\Components\TextInput::make('patrimonio')
                        ->label('Patrimônio')
                        ->unique(ignoreRecord: true)
                        ->maxLength(50)
                        ->placeholder('PAT-00000'),

                    Forms\Components\TextInput::make('fabricante')
                        ->label('Fabricante')
                        ->maxLength(100),

                    Forms\Components\TextInput::make('modelo')
                        ->label('Modelo')
                        ->maxLength(100),

                    Forms\Components\TextInput::make('serie')
                        ->label('Nº de Série')
                        ->maxLength(100),

                    Forms\Components\TextInput::make('tensao')
                        ->label('Tensão')
                        ->maxLength(20)
                        ->placeholder('380V'),

                    Forms\Components\TextInput::make('potencia')
                        ->label('Potência')
                        ->maxLength(20)
                        ->placeholder('15kW'),
                ]),

            Forms\Components\Section::make('Checklists da Máquina')
                ->icon('heroicon-o-clipboard-document-check')
                ->description('Opcional. Se corretiva ou preventiva forem selecionadas, a inspeção será criada como base obrigatória.')
                ->columns(3)
                ->visibleOn('create')
                ->schema([
                    Forms\Components\Toggle::make('criar_checklist_inspecao')
                        ->label('Inspeção')
                        ->default(false)
                        ->dehydrated(false)
                        ->live(),

                    Forms\Components\Toggle::make('criar_checklist_corretiva')
                        ->label('Corretiva')
                        ->default(false)
                        ->dehydrated(false)
                        ->live()
                        ->afterStateUpdated(fn (Forms\Set $set, bool $state) => $state ? $set('criar_checklist_inspecao', true) : null),

                    Forms\Components\Toggle::make('criar_checklist_preventiva')
                        ->label('Preventiva')
                        ->default(false)
                        ->dehydrated(false)
                        ->live()
                        ->afterStateUpdated(fn (Forms\Set $set, bool $state) => $state ? $set('criar_checklist_inspecao', true) : null),
                ]),

            Forms\Components\Section::make('Status e Manutenção')
                ->icon('heroicon-o-wrench')
                ->columns(3)
                ->schema([
                    Forms\Components\Select::make('status')
                        ->label('Status')
                        ->options(StatusMaquina::options())
                        ->required()
                        ->default(StatusMaquina::Operando->value),

                    Forms\Components\Select::make('periodicidade_preventiva')
                        ->label('Periodicidade Preventiva')
                        ->options(PeriodicidadePreventiva::options())
                        ->nullable(),

                    Forms\Components\DatePicker::make('ultima_preventiva')
                        ->label('Última Preventiva')
                        ->native(false)
                        ->nullable(),

                    Forms\Components\Textarea::make('observacoes')
                        ->label('Observações')
                        ->columnSpanFull()
                        ->rows(3),
                ]),

            Forms\Components\Section::make('Foto e Posição no Mapa')
                ->icon('heroicon-o-map-pin')
                ->columns(3)
                ->schema([
                    Forms\Components\FileUpload::make('foto')
                        ->label('Foto da Máquina')
                        ->image()
                        ->disk('s3')
                        ->directory('maquinas')
                        ->imageEditor()
                        ->maxSize(5120)
                        ->columnSpan(1),

                    Forms\Components\TextInput::make('posicao_x')
                        ->label('Posição X (px)')
                        ->numeric()
                        ->default(0)
                        ->minValue(0),

                    Forms\Components\TextInput::make('posicao_y')
                        ->label('Posição Y (px)')
                        ->numeric()
                        ->default(0)
                        ->minValue(0),
                ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('foto')
                    ->label('')
                    ->disk('s3')
                    ->circular()
                    ->defaultImageUrl('https://placehold.co/40x40?text=M')
                    ->size(40),

                Tables\Columns\TextColumn::make('nome')
                    ->label('Máquina')
                    ->searchable()
                    ->sortable()
                    ->description(fn($record) => $record->patrimonio),

                Tables\Columns\TextColumn::make('setor.nome')
                    ->label('Setor')
                    ->badge()
                    ->color('gray')
                    ->sortable(),

                Tables\Columns\TextColumn::make('tipoMaquina.nome')
                    ->label('Tipo')
                    ->placeholder('—')
                    ->badge()
                    ->color('info')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('fabricante')
                    ->label('Fabricante')
                    ->searchable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('modelo')
                    ->label('Modelo')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),

                Tables\Columns\TextColumn::make('ultima_preventiva')
                    ->label('Últ. Preventiva')
                    ->date('d/m/Y')
                    ->placeholder('Nunca'),

                Tables\Columns\TextColumn::make('periodicidade_preventiva')
                    ->label('Periodicidade')
                    ->formatStateUsing(fn($state) => $state?->getLabel())
                    ->placeholder('—')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('ocorrencias_abertas_count')
                    ->label('Ocorrências')
                    ->counts('ocorrenciasAbertas')
                    ->badge()
                    ->color(fn($state) => $state > 0 ? 'danger' : 'success'),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('setor_id')
                    ->label('Setor')
                    ->options(Setor::ativos()->pluck('nome', 'id'))
                    ->searchable(),

                Tables\Filters\SelectFilter::make('status')
                    ->label('Status')
                    ->options(StatusMaquina::options()),

                Tables\Filters\SelectFilter::make('periodicidade_preventiva')
                    ->label('Periodicidade')
                    ->options(PeriodicidadePreventiva::options()),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\Action::make('ver_mapa')
                    ->label('Ver no Mapa')
                    ->icon('heroicon-o-map')
                    ->color('info')
                    ->url(fn($record) => \App\Filament\Pages\MapaMaquinas::getUrl(['setor' => $record->setor_id])),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist->schema([
            Infolists\Components\Section::make('Identificação')->columns(3)->schema([
                Infolists\Components\TextEntry::make('nome')->label('Máquina'),
                Infolists\Components\TextEntry::make('patrimonio')->label('Patrimônio')->placeholder('—'),
                Infolists\Components\TextEntry::make('setor.nome')->label('Setor')->badge()->color('gray'),
                Infolists\Components\TextEntry::make('fabricante')->label('Fabricante')->placeholder('—'),
                Infolists\Components\TextEntry::make('modelo')->label('Modelo')->placeholder('—'),
                Infolists\Components\TextEntry::make('serie')->label('Nº Série')->placeholder('—'),
                Infolists\Components\TextEntry::make('tensao')->label('Tensão')->placeholder('—'),
                Infolists\Components\TextEntry::make('potencia')->label('Potência')->placeholder('—'),
                Infolists\Components\TextEntry::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),
            ]),

            Infolists\Components\Section::make('Manutenção')->columns(3)->schema([
                Infolists\Components\TextEntry::make('ultima_preventiva')->label('Última Preventiva')->date('d/m/Y')->placeholder('Nunca'),
                Infolists\Components\TextEntry::make('periodicidade_preventiva')->label('Periodicidade')
                    ->formatStateUsing(fn($state) => $state?->getLabel())->placeholder('—'),
                Infolists\Components\TextEntry::make('observacoes')->label('Observações')->placeholder('—')->columnSpanFull(),
            ]),

            Infolists\Components\Section::make('Foto')->schema([
                Infolists\Components\ImageEntry::make('foto')->disk('s3')->height(200)->placeholder('Sem foto'),
            ]),
        ]);
    }

    public static function getRelationManagers(): array
    {
        return [
            OcorrenciasRelationManager::class,
            PreventivasRelationManager::class,
            ChecklistModeloRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListMaquinas::route('/'),
            'create' => Pages\CreateMaquina::route('/create'),
            'edit'   => Pages\EditMaquina::route('/{record}/edit'),
            'view'   => Pages\ViewMaquina::route('/{record}'),
        ];
    }
}
