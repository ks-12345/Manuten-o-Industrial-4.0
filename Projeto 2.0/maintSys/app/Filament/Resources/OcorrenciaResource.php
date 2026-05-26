<?php

namespace App\Filament\Resources;

use App\Enums\PrioridadeOcorrencia;
use App\Enums\StatusOcorrencia;
use App\Filament\Resources\OcorrenciaResource\Pages;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Services\CorretivaService;
use App\Services\InspecaoService;
use App\Services\OcorrenciaService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

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
                            ->searchable()
                            ->preload()
                            ->required()
                            ->reactive()
                            ->afterStateUpdated(function ($state, Forms\Set $set): void {
                                if (! $state) {
                                    return;
                                }

                                $set('setor_id', Maquina::find($state)?->setor_id);
                            }),
                        Forms\Components\Select::make('setor_id')
                            ->relationship('setor', 'nome')
                            ->searchable()
                            ->preload()
                            ->required()
                            ->disabled(),
                    ]),
                    Forms\Components\TextInput::make('titulo')
                        ->required()
                        ->maxLength(255)
                        ->columnSpanFull(),
                    Forms\Components\Textarea::make('descricao')
                        ->required()
                        ->rows(4)
                        ->columnSpanFull(),
                    Forms\Components\Grid::make(2)->schema([
                        Forms\Components\Select::make('prioridade')
                            ->options(PrioridadeOcorrencia::class)
                            ->required()
                            ->default('media'),
                        Forms\Components\Select::make('status')
                            ->options(StatusOcorrencia::class)
                            ->default('aberto')
                            ->hiddenOn('create'),
                    ]),
                    Forms\Components\FileUpload::make('foto')
                        ->disk(config('maintsys.upload_disk'))
                        ->image()
                        ->directory('ocorrencias')
                        ->columnSpanFull(),
                ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('created_at', 'desc')
            ->columns([
                Tables\Columns\TextColumn::make('codigo')
                    ->badge()
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('titulo')
                    ->searchable()
                    ->limit(40)
                    ->weight('bold'),
                Tables\Columns\TextColumn::make('maquina.nome')
                    ->searchable(),
                Tables\Columns\TextColumn::make('setor.nome')
                    ->badge()
                    ->color('gray'),
                Tables\Columns\TextColumn::make('prioridade')
                    ->badge()
                    ->formatStateUsing(fn ($state) => $state->getLabel())
                    ->color(fn ($state) => $state->getColor()),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->formatStateUsing(fn ($state) => $state->getLabel())
                    ->color(fn ($state) => $state->getColor()),
                Tables\Columns\TextColumn::make('abertoPor.name')
                    ->label('Aberto por'),
                Tables\Columns\TextColumn::make('tecnico.name')
                    ->label('Técnico'),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Abertura')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
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
                    ->visible(fn (Ocorrencia $record): bool => $record->status === StatusOcorrencia::Aberto && auth()->user()?->hasRole('tecnico'))
                    ->action(function (Ocorrencia $record): void {
                        app(OcorrenciaService::class)->assumir($record);

                        Notification::make()->success()->title('Ocorrência assumida')->send();
                    }),
                Tables\Actions\Action::make('iniciar_inspecao')
                    ->label('Iniciar inspeção')
                    ->icon('heroicon-o-clipboard-document-check')
                    ->color('info')
                    ->visible(fn (Ocorrencia $record): bool => $record->status === StatusOcorrencia::EmAnalise)
                    ->action(function (Ocorrencia $record) {
                        $inspecao = $record->inspecao ?: app(InspecaoService::class)->iniciar($record);

                        Notification::make()->success()->title('Inspeção iniciada')->send();

                        return redirect()->to(InspecaoResource::getUrl('executar', ['record' => $inspecao]));
                    }),
                Tables\Actions\Action::make('executar_inspecao')
                    ->label('Executar inspeção')
                    ->icon('heroicon-o-play')
                    ->color('warning')
                    ->visible(fn (Ocorrencia $record): bool => filled($record->inspecao))
                    ->url(fn (Ocorrencia $record): string => InspecaoResource::getUrl('executar', ['record' => $record->inspecao])),
                Tables\Actions\Action::make('criar_corretiva')
                    ->label('Criar corretiva')
                    ->icon('heroicon-o-wrench-screwdriver')
                    ->color('danger')
                    ->visible(fn (Ocorrencia $record): bool => filled($record->inspecao) && blank($record->corretiva))
                    ->action(function (Ocorrencia $record) {
                        $corretiva = app(CorretivaService::class)->criarAPartirDaInspecao($record->inspecao, []);

                        Notification::make()->success()->title('Corretiva criada')->send();

                        return redirect()->to(CorretivaResource::getUrl('executar', ['record' => $corretiva]));
                    }),
                Tables\Actions\Action::make('executar_corretiva')
                    ->label('Executar corretiva')
                    ->icon('heroicon-o-play-circle')
                    ->color('danger')
                    ->visible(fn (Ocorrencia $record): bool => filled($record->corretiva))
                    ->url(fn (Ocorrencia $record): string => CorretivaResource::getUrl('executar', ['record' => $record->corretiva])),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListOcorrencias::route('/'),
            'create' => Pages\CreateOcorrencia::route('/create'),
            'edit' => Pages\EditOcorrencia::route('/{record}/edit'),
        ];
    }
}
