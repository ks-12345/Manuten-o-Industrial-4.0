<?php

namespace App\Filament\Resources;

use App\Enums\TipoCorretiva;
use App\Filament\Resources\CorretivaResource\Pages;
use App\Models\Corretiva;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\User;
use App\Services\CorretivaService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class CorretivaResource extends Resource
{
    protected static ?string $model           = Corretiva::class;
    protected static ?string $navigationIcon  = 'heroicon-o-wrench-screwdriver';
    protected static ?string $navigationGroup = 'Manutenção';
    protected static ?string $navigationLabel = 'Corretivas';
    protected static ?string $modelLabel      = 'Corretiva';
    protected static ?int    $navigationSort  = 1;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('corretivas.view') ?? false;
    }

    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery()->with(['maquina.setor', 'tecnico', 'ocorrencia']);
        $user  = Auth::user();

        if (!$user->hasRole('admin')) {
            $query->where('tecnico_id', $user->id);
        }

        return $query;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Informações Básicas')->columns(2)->schema([
                Forms\Components\Select::make('maquina_id')
                    ->label('Máquina')
                    ->options(Maquina::with('setor')->get()->mapWithKeys(fn($m) => [$m->id => "{$m->nome} — {$m->setor?->nome}"]))
                    ->searchable()
                    ->required()
                    ->live(),

                Forms\Components\Select::make('tipo')
                    ->label('Tipo de Corretiva')
                    ->options(TipoCorretiva::options())
                    ->required()
                    ->default(TipoCorretiva::Direta->value)
                    ->live(),

                Forms\Components\Select::make('tecnico_id')
                    ->label('Técnico')
                    ->options(User::role('tecnico')->ativos()->pluck('name', 'id'))
                    ->default(Auth::id())
                    ->required(),

                // Mostrar ocorrência apenas se tipo = origem_ocorrencia
                Forms\Components\Select::make('ocorrencia_id')
                    ->label('Ocorrência Vinculada')
                    ->options(fn(Forms\Get $get) =>
                        Ocorrencia::where('maquina_id', $get('maquina_id'))
                            ->whereIn('status', ['em_analise', 'aguardando_peca', 'em_corretiva'])
                            ->pluck('titulo', 'id'))
                    ->searchable()
                    ->nullable()
                    ->visible(fn(Forms\Get $get) => $get('tipo') === TipoCorretiva::OrigemOcorrencia->value),

                Forms\Components\Textarea::make('problema')
                    ->label('Descrição do Problema')
                    ->required()
                    ->rows(4)
                    ->columnSpanFull(),
            ]),

            Forms\Components\Section::make('Execução (preencher ao finalizar)')->columns(2)->schema([
                Forms\Components\Textarea::make('solucao')
                    ->label('Solução Aplicada')
                    ->rows(4)
                    ->columnSpanFull(),

                Forms\Components\Textarea::make('resumo')
                    ->label('Resumo Técnico')
                    ->rows(3)
                    ->columnSpanFull(),

                Forms\Components\TextInput::make('custo_pecas')
                    ->label('Custo de Peças (R$)')
                    ->numeric()
                    ->prefix('R$')
                    ->default(0),

                Forms\Components\TextInput::make('custo_mao_obra')
                    ->label('Custo de Mão de Obra (R$)')
                    ->numeric()
                    ->prefix('R$')
                    ->default(0),
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

                Tables\Columns\TextColumn::make('tipo')
                    ->label('Tipo')
                    ->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())
                    ->color(fn($s) => match($s) {
                        TipoCorretiva::OrigemOcorrencia => 'warning',
                        TipoCorretiva::Direta           => 'info',
                    }),

                Tables\Columns\TextColumn::make('tecnico.name')
                    ->label('Técnico'),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn($s) => $s === 'finalizada' ? 'success' : 'warning')
                    ->formatStateUsing(fn($s) => $s === 'finalizada' ? 'Finalizada' : 'Em Andamento'),

                Tables\Columns\TextColumn::make('inicio')
                    ->label('Iniciada em')
                    ->dateTime('d/m/Y H:i'),

                Tables\Columns\TextColumn::make('tempo_reparo')
                    ->label('Tempo')
                    ->formatStateUsing(fn($s) => $s ? gmdate('H\h i\m', $s * 60) : '—'),

                Tables\Columns\TextColumn::make('custo_total')
                    ->label('Custo Total')
                    ->getStateUsing(fn($r) => 'R$ ' . number_format($r->custoTotal(), 2, ',', '.')),
            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                Tables\Filters\SelectFilter::make('tipo')->label('Tipo')->options(TipoCorretiva::options()),
                Tables\Filters\SelectFilter::make('status')->label('Status')->options([
                    'em_andamento' => 'Em Andamento',
                    'finalizada'   => 'Finalizada',
                ]),
            ])
            ->actions([
                Tables\Actions\Action::make('executar')
                    ->label('Executar')
                    ->icon('heroicon-o-play')
                    ->color('primary')
                    ->url(fn($r) => Pages\ExecutarCorretiva::getUrl(['record' => $r]))
                    ->visible(fn($r) => !$r->estaFinalizada()),

                Tables\Actions\EditAction::make()
                    ->visible(fn($r) => Auth::user()->hasRole('admin')),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index'    => Pages\ListCorretivas::route('/'),
            'create'   => Pages\CreateCorretiva::route('/create'),
            'executar' => Pages\ExecutarCorretiva::route('/{record}/executar'),
        ];
    }
}