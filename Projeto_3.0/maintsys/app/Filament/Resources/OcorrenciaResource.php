<?php

namespace App\Filament\Resources;

use App\Enums\PrioridadeOcorrencia;
use App\Enums\StatusOcorrencia;
use App\Filament\Resources\OcorrenciaResource\Pages;
use App\Filament\Resources\OcorrenciaResource\RelationManagers\HistoricoRelationManager;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\User;
use App\Services\OcorrenciaService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class OcorrenciaResource extends Resource
{
    protected static ?string $model           = Ocorrencia::class;
    protected static ?string $navigationIcon  = 'heroicon-o-exclamation-triangle';
    protected static ?string $navigationGroup = 'Operações';
    protected static ?string $navigationLabel = 'Ocorrências';
    protected static ?string $modelLabel      = 'Ocorrência';
    protected static ?int    $navigationSort  = 1;

    public static function canAccess(): bool
    {
        $user = auth()->user();
        return $user?->hasPermissionTo('ocorrencias.view')
            || $user?->hasPermissionTo('ocorrencias.view_own')
            || $user?->hasPermissionTo('ocorrencias.create');
    }

    /** Filtrar ocorrências por perfil do usuário logado */
    public static function getEloquentQuery(): Builder
    {
        $user = auth()->user();
        $query = parent::getEloquentQuery()->with(['maquina.setor', 'professor', 'tecnico']);

        // Professor vê apenas as próprias ocorrências
        if ($user->hasPermissionTo('ocorrencias.view_own') && !$user->hasPermissionTo('ocorrencias.view')) {
            $query->where('professor_id', $user->id);
        }

        // Técnico vê apenas as suas (atribuídas) ou abertas sem técnico
        if ($user->hasRole('tecnico') && !$user->hasRole('admin')) {
            if (session('perfil_ativo') === 'tecnico') {
                $query->where(fn($q) => $q->where('tecnico_id', $user->id)
                                           ->orWhere(fn($q2) => $q2->where('status', 'aberta')
                                                                    ->whereNull('tecnico_id')));
            }
        }

        return $query;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make()->columns(2)->schema([
                Forms\Components\Select::make('maquina_id')
                    ->label('Máquina')
                    ->options(Maquina::with('setor')->get()->mapWithKeys(fn($m) => [$m->id => "{$m->nome} — {$m->setor?->nome}"]))
                    ->searchable()
                    ->required(),

                Forms\Components\Select::make('prioridade')
                    ->label('Prioridade')
                    ->options(PrioridadeOcorrencia::options())
                    ->required()
                    ->default(PrioridadeOcorrencia::Media->value),

                Forms\Components\TextInput::make('titulo')
                    ->label('Título da Ocorrência')
                    ->required()
                    ->maxLength(200)
                    ->columnSpanFull(),

                Forms\Components\Textarea::make('descricao')
                    ->label('Descrição Detalhada')
                    ->required()
                    ->rows(5)
                    ->columnSpanFull(),
            ]),

            Forms\Components\Section::make('Atribuição (Admin)')
                ->icon('heroicon-o-user-plus')
                ->columns(2)
                ->visible(fn() => auth()->user()->hasRole('admin'))
                ->schema([
                    Forms\Components\Select::make('tecnico_id')
                        ->label('Técnico Responsável')
                        ->options(User::role('tecnico')->ativos()->pluck('name', 'id'))
                        ->searchable()
                        ->nullable(),

                    Forms\Components\Select::make('status')
                        ->label('Status')
                        ->options(StatusOcorrencia::options())
                        ->default(StatusOcorrencia::Aberta->value),
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
                    ->color('primary'),

                Tables\Columns\TextColumn::make('titulo')
                    ->label('Título')
                    ->searchable()
                    ->limit(40)
                    ->description(fn($record) => $record->maquina?->nome),

                Tables\Columns\TextColumn::make('maquina.setor.nome')
                    ->label('Setor')
                    ->badge()
                    ->color('gray')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('professor.name')
                    ->label('Professor')
                    ->searchable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('tecnico.name')
                    ->label('Técnico')
                    ->placeholder('Sem técnico')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('prioridade')
                    ->label('Prioridade')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Aberta em')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Status')
                    ->options(StatusOcorrencia::options()),

                Tables\Filters\SelectFilter::make('prioridade')
                    ->label('Prioridade')
                    ->options(PrioridadeOcorrencia::options()),

                Tables\Filters\SelectFilter::make('maquina_id')
                    ->label('Máquina')
                    ->relationship('maquina', 'nome')
                    ->searchable(),

                Tables\Filters\Filter::make('sem_tecnico')
                    ->label('Sem Técnico Atribuído')
                    ->query(fn(Builder $q) => $q->whereNull('tecnico_id')),

                Tables\Filters\Filter::make('minhas')
                    ->label('Minhas Ocorrências')
                    ->query(fn(Builder $q) => $q->where('professor_id', auth()->id())),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),

                // Ação: Assumir (Técnico)
                Tables\Actions\Action::make('assumir')
                    ->label('Assumir')
                    ->icon('heroicon-o-hand-raised')
                    ->color('success')
                    ->requiresConfirmation()
                    ->modalDescription('Você será atribuído como técnico responsável por esta ocorrência.')
                    ->visible(fn($record) => auth()->user()->can('assumir', $record))
                    ->action(function ($record) {
                        app(OcorrenciaService::class)->assumir($record, auth()->user());
                        Notification::make()->success()->title('Ocorrência assumida!')->send();
                    }),

                // Ação: Cancelar (Admin)
                Tables\Actions\Action::make('cancelar')
                    ->label('Cancelar')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->form([
                        Forms\Components\Textarea::make('motivo')
                            ->label('Motivo do Cancelamento')
                            ->required()
                            ->rows(3),
                    ])
                    ->visible(fn($record) => auth()->user()->can('cancelar', $record))
                    ->action(function ($record, array $data) {
                        app(OcorrenciaService::class)->cancelar($record, auth()->user(), $data['motivo']);
                        Notification::make()->success()->title('Ocorrência cancelada.')->send();
                    }),

                // Ação: Iniciar Inspeção
                Tables\Actions\Action::make('iniciar_inspecao')
                    ->label('Iniciar Inspeção')
                    ->icon('heroicon-o-magnifying-glass')
                    ->color('info')
                    ->visible(fn($record) => $record->tecnico_id === auth()->id()
                        && $record->status->value === 'em_analise'
                        && !$record->inspecao)
                    ->action(function ($record) {
                        app(\App\Services\InspecaoService::class)->iniciar($record, auth()->user());
                        Notification::make()->success()->title('Inspeção iniciada!')->send();
                    }),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([]),
            ]);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist->schema([
            Infolists\Components\Section::make('Ocorrência')->columns(3)->schema([
                Infolists\Components\TextEntry::make('codigo')->label('Código')->badge()->color('primary'),
                Infolists\Components\TextEntry::make('status')->label('Status')->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),
                Infolists\Components\TextEntry::make('prioridade')->label('Prioridade')->badge()
                    ->formatStateUsing(fn($state) => $state->getLabel())
                    ->color(fn($state) => $state->getColor()),
                Infolists\Components\TextEntry::make('titulo')->label('Título')->columnSpanFull(),
                Infolists\Components\TextEntry::make('descricao')->label('Descrição')->columnSpanFull(),
            ]),

            Infolists\Components\Section::make('Envolvidos')->columns(3)->schema([
                Infolists\Components\TextEntry::make('maquina.nome')->label('Máquina'),
                Infolists\Components\TextEntry::make('professor.name')->label('Professor'),
                Infolists\Components\TextEntry::make('tecnico.name')->label('Técnico')->placeholder('Não atribuído'),
                Infolists\Components\TextEntry::make('assumida_em')->label('Assumida em')->dateTime('d/m/Y H:i')->placeholder('—'),
                Infolists\Components\TextEntry::make('finalizada_em')->label('Finalizada em')->dateTime('d/m/Y H:i')->placeholder('—'),
            ]),

            Infolists\Components\Section::make('Inspeção')
                ->visible(fn($record) => $record->inspecao !== null)
                ->schema([
                    Infolists\Components\TextEntry::make('inspecao.diagnostico')->label('Diagnóstico'),
                    Infolists\Components\TextEntry::make('inspecao.necessita_peca')->label('Necessita Peça?')
                        ->formatStateUsing(fn($state) => $state === null ? '—' : ($state ? '✅ Sim' : '❌ Não')),
                ]),
        ]);
    }

    public static function getRelationManagers(): array
    {
        return [
            HistoricoRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListOcorrencias::route('/'),
            'create' => Pages\CreateOcorrencia::route('/create'),
            'view'   => Pages\ViewOcorrencia::route('/{record}'),
        ];
    }
}