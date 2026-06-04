<?php

namespace App\Filament\Resources;

use App\Enums\PeriodicidadePreventiva;
use App\Filament\Resources\PreventivaResource\Pages;
use App\Models\Maquina;
use App\Models\Preventiva;
use App\Models\User;
use App\Services\PreventivaService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class PreventivaResource extends Resource
{
    protected static ?string $model           = Preventiva::class;
    protected static ?string $navigationIcon  = 'heroicon-o-calendar-days';
    protected static ?string $navigationGroup = 'Manutenção';
    protected static ?string $navigationLabel = 'Preventivas';
    protected static ?string $modelLabel      = 'Preventiva';
    protected static ?int    $navigationSort  = 2;

    public static function canAccess(): bool
    {
        return auth()->user()?->hasPermissionTo('preventivas.view') ?? false;
    }

    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery()->with(['maquina.setor', 'tecnico']);
        $user  = auth()->user();

        if (!$user->hasRole('admin')) {
            $query->where(fn($q) => $q->where('tecnico_id', $user->id)
                                      ->orWhereNull('tecnico_id'));
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

                Forms\Components\Select::make('periodicidade')
                    ->label('Periodicidade')
                    ->options(PeriodicidadePreventiva::options())
                    ->required(),

                Forms\Components\DatePicker::make('data_prevista')
                    ->label('Data Prevista')
                    ->native(false)
                    ->required(),

                Forms\Components\Select::make('tecnico_id')
                    ->label('Técnico')
                    ->options(User::role('tecnico')->ativos()->pluck('name', 'id'))
                    ->searchable()
                    ->nullable(),
            ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('maquina.nome')
                    ->label('Máquina')
                    ->searchable()
                    ->description(fn($r) => $r->maquina?->setor?->nome),

                Tables\Columns\TextColumn::make('periodicidade')
                    ->label('Periodicidade')
                    ->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())
                    ->color('info'),

                Tables\Columns\TextColumn::make('data_prevista')
                    ->label('Data Prevista')
                    ->date('d/m/Y')
                    ->sortable()
                    ->color(fn($record) => $record->estaAtrasada() ? 'danger' : null),

                Tables\Columns\TextColumn::make('tecnico.name')
                    ->label('Técnico')
                    ->placeholder('Não atribuído'),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn($s) => match($s) {
                        'realizada'    => 'success',
                        'em_andamento' => 'info',
                        'atrasada'     => 'danger',
                        default        => 'warning',
                    })
                    ->formatStateUsing(fn($s) => match($s) {
                        'realizada'    => 'Realizada',
                        'em_andamento' => 'Em Andamento',
                        'atrasada'     => 'Atrasada',
                        default        => 'Pendente',
                    }),

                Tables\Columns\TextColumn::make('data_realizada')
                    ->label('Realizada em')
                    ->date('d/m/Y')
                    ->placeholder('—'),

                Tables\Columns\TextColumn::make('custo')
                    ->label('Custo')
                    ->money('BRL')
                    ->toggleable(),
            ])
            ->defaultSort('data_prevista', 'asc')
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Status')
                    ->options([
                        'pendente'     => 'Pendente',
                        'em_andamento' => 'Em Andamento',
                        'realizada'    => 'Realizada',
                        'atrasada'     => 'Atrasada',
                    ]),

                Tables\Filters\SelectFilter::make('periodicidade')
                    ->label('Periodicidade')
                    ->options(PeriodicidadePreventiva::options()),

                Tables\Filters\Filter::make('atrasadas')
                    ->label('Apenas Atrasadas')
                    ->query(fn($q) => $q->where('status', 'atrasada')
                                        ->orWhere(fn($q2) => $q2->where('status', 'pendente')
                                                                 ->where('data_prevista', '<', now()))),
            ])
            ->actions([
                Tables\Actions\Action::make('iniciar')
                    ->label('Iniciar')
                    ->icon('heroicon-o-play')
                    ->color('info')
                    ->visible(fn($r) => in_array($r->status, ['pendente', 'atrasada']))
                    ->requiresConfirmation()
                    ->action(function ($record) {
                        app(PreventivaService::class)->iniciar($record, auth()->user());
                        Notification::make()->success()->title('Preventiva iniciada!')->send();
                    }),

                Tables\Actions\Action::make('executar')
                    ->label('Finalizar')
                    ->icon('heroicon-o-check-circle')
                    ->color('success')
                    ->form([
                        Forms\Components\Textarea::make('observacoes')->label('Observações')->rows(3),
                        Forms\Components\TextInput::make('tempo_execucao')->label('Tempo (min)')->numeric(),
                        Forms\Components\TextInput::make('custo')->label('Custo (R$)')->numeric()->prefix('R$')->default(0),
                    ])
                    ->visible(fn($r) => $r->status === 'em_andamento')
                    ->action(function ($record, array $data) {
                        app(PreventivaService::class)->finalizar(
                            $record,
                            auth()->user(),
                            $data['observacoes']    ?? null,
                            (float) ($data['custo']          ?? 0),
                            isset($data['tempo_execucao']) ? (int) $data['tempo_execucao'] : null,
                        );
                        Notification::make()->success()->title('Preventiva realizada!')->send();
                    }),

                Tables\Actions\EditAction::make()
                    ->visible(fn($r) => $r->status === 'pendente' && auth()->user()->hasRole('admin')),
            ])
            ->headerActions([
                Tables\Actions\Action::make('gerar_automaticas')
                    ->label('Gerar Automáticas')
                    ->icon('heroicon-o-sparkles')
                    ->color('warning')
                    ->visible(fn() => auth()->user()->hasRole('admin'))
                    ->requiresConfirmation()
                    ->modalDescription('Isso irá gerar preventivas para os próximos 3 meses para todas as máquinas configuradas.')
                    ->action(function () {
                        $resultado = app(PreventivaService::class)->gerarPreventivasFuturas(3);
                        Notification::make()->success()
                            ->title("✅ {$resultado['geradas']} preventivas geradas!")
                            ->send();
                    }),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListPreventivas::route('/'),
            'create' => \Filament\Resources\Pages\CreateRecord::class,
        ];
    }
}