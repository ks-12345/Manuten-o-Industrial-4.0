<?php

namespace App\Filament\Resources;

use App\Enums\StatusOcorrencia;
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
use Filament\Tables\Actions\Action;

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
                            ->whereIn('status', [
                                StatusOcorrencia::Corretiva->value,
                                StatusOcorrencia::AguardandoOrcamento->value,
                            ])
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
                ->searchable(),

            Tables\Columns\TextColumn::make('tipo')
                ->label('Tipo'),

            // Modifique a coluna do técnico para mostrar um aviso se estiver sem dono
            Tables\Columns\TextColumn::make('tecnico.name')
                ->label('Técnico')
                ->placeholder('Aguardando técnico...'), 

            Tables\Columns\TextColumn::make('status')
                ->badge()
                ->color(fn (string $state): string => match ($state) {
                    'pendente' => 'danger',
                    'em_andamento' => 'warning',
                    'finalizada' => 'success',
                    default => 'gray',
                }),

            Tables\Columns\TextColumn::make('inicio')
                ->label('Iniciada em')
                ->dateTime('d/m/Y H:i')
                ->placeholder('Não iniciada'),
                
            // ... suas outras colunas (Tempo, Custo Total, etc)
        ])
        ->actions([
            // BOTÃO MÁGICO PARA ASSUMIR A MANUTENÇÃO:
            Action::make('assumirCorretiva')
                ->label('Assumir Corretiva')
                ->icon('heroicon-o-wrench-screwdriver')
                ->color('success')
                ->requiresConfirmation()
                ->modalHeading('Deseja assumir esta manutenção?')
                ->modalDescription('Você será registrado como o técnico responsável e a ordem mudará para "Em Andamento" agora.')
                ->visible(fn ($record) => $record->status === 'pendente') // Só aparece se estiver pendente!
                ->action(function ($record) {
                    $record->update([
                        'tecnico_id' => Auth::id(),
                        'status' => 'em_andamento',
                        'inicio' => now(),
                    ]);

                    Notification::make()
                        ->title('Manutenção assumida com sucesso!')
                        ->body('Você já pode iniciar os trabalhos.')
                        ->success()
                        ->send();
                }),

            Tables\Actions\EditAction::make()
                ->visible(fn ($record) => $record->status === 'em_andamento'), // Só edita se já tiver dono
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
