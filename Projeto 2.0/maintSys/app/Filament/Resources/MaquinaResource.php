<?php
namespace App\Filament\Resources;

use App\Models\Maquina;
use App\Enums\StatusMaquina;
use App\Enums\PeriodicidadePreventiva;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class MaquinaResource extends Resource
{
    protected static ?string $model = Maquina::class;
    protected static ?string $navigationIcon = 'heroicon-o-cog-6-tooth';
    protected static ?string $navigationGroup = 'Infraestrutura';
    protected static ?int $navigationSort = 2;
    protected static ?string $label = 'Máquina';
    protected static ?string $pluralLabel = 'Máquinas';

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Identificação')
                ->icon('heroicon-o-identification')
                ->schema([
                    Forms\Components\Grid::make(3)->schema([
                        Forms\Components\Select::make('setor_id')
                            ->relationship('setor', 'nome')
                            ->searchable()->preload()->required(),
                        Forms\Components\TextInput::make('nome')
                            ->required()->maxLength(255)->columnSpan(2),
                    ]),
                    Forms\Components\Grid::make(3)->schema([
                        Forms\Components\TextInput::make('modelo')->maxLength(255),
                        Forms\Components\TextInput::make('fabricante')->maxLength(255),
                        Forms\Components\TextInput::make('numero_serie')
                            ->unique(ignoreRecord: true)->maxLength(255),
                    ]),
                    Forms\Components\Grid::make(3)->schema([
                        Forms\Components\TextInput::make('patrimonio')
                            ->unique(ignoreRecord: true)->maxLength(255),
                        Forms\Components\TextInput::make('tensao')->maxLength(50),
                        Forms\Components\TextInput::make('potencia')->maxLength(50),
                    ]),
                ]),

            Forms\Components\Section::make('Datas e Status')
                ->icon('heroicon-o-calendar')
                ->schema([
                    Forms\Components\Grid::make(3)->schema([
                        Forms\Components\DatePicker::make('data_aquisicao')
                            ->label('Data de Aquisição'),
                        Forms\Components\DatePicker::make('data_instalacao')
                            ->label('Data de Instalação'),
                        Forms\Components\Select::make('status')
                            ->options(StatusMaquina::class)
                            ->required()->default('operando'),
                    ]),
                ]),

            Forms\Components\Section::make('Manutenção Preventiva')
                ->icon('heroicon-o-arrow-path')
                ->schema([
                    Forms\Components\Grid::make(3)->schema([
                        Forms\Components\Select::make('periodicidade_preventiva')
                            ->options(PeriodicidadePreventiva::class)
                            ->label('Periodicidade'),
                        Forms\Components\DatePicker::make('ultima_preventiva')
                            ->label('Última Preventiva'),
                        Forms\Components\DatePicker::make('proxima_preventiva')
                            ->label('Próxima Preventiva'),
                    ]),
                ]),

            Forms\Components\Section::make('Mídia e Observações')
                ->schema([
                    Forms\Components\FileUpload::make('foto')
                        ->image()->imageEditor()
                        ->directory('maquinas')->columnSpanFull(),
                    Forms\Components\Textarea::make('observacoes')
                        ->rows(3)->columnSpanFull(),
                    Forms\Components\Toggle::make('ativo')->default(true),
                ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('foto')
                    ->circular()->size(40),
                Tables\Columns\TextColumn::make('patrimonio')
                    ->badge()->searchable(),
                Tables\Columns\TextColumn::make('nome')
                    ->searchable()->sortable()->weight('bold'),
                Tables\Columns\TextColumn::make('setor.nome')
                    ->badge()->color('gray'),
                Tables\Columns\TextColumn::make('modelo')
                    ->searchable()->toggleable(),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => match($state) {
                        StatusMaquina::Operando   => 'success',
                        StatusMaquina::Atencao    => 'warning',
                        StatusMaquina::Quebrada   => 'danger',
                        StatusMaquina::Manutencao => 'info',
                    }),
                Tables\Columns\TextColumn::make('proxima_preventiva')
                    ->label('Próx. Preventiva')
                    ->date('d/m/Y')
                    ->color(fn($record) => $record->isPreventivaAtrasada() ? 'danger' : (
                        $record->isPreventivaPróxima() ? 'warning' : 'success'
                    )),
                Tables\Columns\IconColumn::make('ativo')->boolean(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('setor')
                    ->relationship('setor', 'nome'),
                Tables\Filters\SelectFilter::make('status')
                    ->options(StatusMaquina::class),
                Tables\Filters\TernaryFilter::make('ativo'),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
            ]);
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