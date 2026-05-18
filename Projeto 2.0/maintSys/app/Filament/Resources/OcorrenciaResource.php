<?php
namespace App\Filament\Resources;

use App\Models\Ocorrencia;
use App\Enums\StatusOcorrencia;
use App\Enums\PrioridadeOcorrencia;
use App\Services\OcorrenciaService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Notifications\Notification;

class OcorrenciaResource extends Resource
{
    protected static ?string $model = Ocorrencia::class;
    protected static ?string $navigationIcon = 'heroicon-o-exclamation-triangle';
    protected static ?string $navigationGroup = 'Manutenção';
    protected static ?int $navigationSort = 1;
    protected static ?string $label = 'Ocorrência';
    protected static ?string $pluralLabel = 'Ocorrências';

    public static function getNavigationBadge(): ?string
    {
        return (string) Ocorrencia::whereIn('status', ['aberto', 'em_analise'])->count();
    }

    public static function getNavigationBadgeColor(): string
    {
        return Ocorrencia::where('status', 'aberto')->count() > 0 ? 'danger' : 'warning';
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Dados da Ocorrência')
                ->schema([
                    Forms\Components\Grid::make(2)->schema([
                        Forms\Components\Select::make('maquina_id')
                            ->relationship('maquina', 'nome')
                            ->searchable()->preload()->required()
                            ->reactive()
                            ->afterStateUpdated(function ($state, Forms\Set $set) {
                                if ($state) {
                                    $maquina = \App\Models\Maquina::find($state);
                                    $set('setor_id', $maquina?->setor_id);
                                }
                            }),
                        Forms\Components\Select::make('setor_id')
                            ->relationship('setor', 'nome')
                            ->searchable()->preload()->required()->disabled(),
                    ]),
                    Forms\Components\TextInput::make('titulo')
                        ->required()->maxLength(255)->columnSpanFull(),
                    Forms\Components\Textarea::make('descricao')
                        ->required()->rows(4)->columnSpanFull(),
                    Forms\Components\Grid::make(2)->schema([
                        Forms\Components\Select::make('prioridade')
                            ->options(PrioridadeOcorrencia::class)
                            ->required()->default('media'),
                        Forms\Components\Select::make('status')
                            ->options(StatusOcorrencia::class)
                            ->default('aberto')
                            ->hiddenOn('create'),
                    ]),
                    Forms\Components\FileUpload::make('foto')
                        ->image()->directory('ocorrencias')->columnSpanFull(),
                ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('created_at', 'desc')
            ->columns([
                Tables\Columns\TextColumn::make('codigo')
                    ->badge()->searchable()->sortable(),
                Tables\Columns\TextColumn::make('titulo')
                    ->searchable()->limit(40)->weight('bold'),
                Tables\Columns\TextColumn::make('maquina.nome')
                    ->searchable(),
                Tables\Columns\TextColumn::make('setor.nome')
                    ->badge()->color('gray'),
                Tables\Columns\TextColumn::make('prioridade')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),
                Tables\Columns\TextColumn::make('abertoPor.name')
                    ->label('Aberto por'),
                Tables\Columns\TextColumn::make('tecnico.name')
                    ->label('Técnico'),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Abertura')
                    ->dateTime('d/m/Y H:i')->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options(StatusOcorrencia::class),
                Tables\Filters\SelectFilter::make('prioridade')
                    ->options(PrioridadeOcorrencia::class),
                Tables\Filters\SelectFilter::make('setor')
                    ->relationship('setor', 'nome'),
            ])
            ->actions([
                Tables\Actions\Action::make('assumir')
                    ->label('Assumir')
                    ->icon('heroicon-o-hand-raised')
                    ->color('warning')
                    ->visible(fn($record) => $record->status === StatusOcorrencia::Aberto && auth()->user()->hasRole('tecnico'))
                    ->action(function ($record) {
                        app(OcorrenciaService::class)->assumir($record);
                        Notification::make()->success()->title('Ocorrência assumida!')->send();
                    }),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListOcorrencias::route('/'),
            'create' => Pages\CreateOcorrencia::route('/create'),
            'edit'   => Pages\EditOcorrencia::route('/{record}/edit'),
            'view'   => Pages\ViewOcorrencia::route('/{record}'),
        ];
    }
}