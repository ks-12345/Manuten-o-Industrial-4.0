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

                Forms\Components\Select::make('maquina_id')
                    ->relationship('maquina', 'nome')
                    ->searchable()
                    ->preload()
                    ->required()
                    ->reactive()
                    ->afterStateUpdated(function ($state, Forms\Set $set) {
                        $maquina = Maquina::find($state);

                        $set('setor_id', $maquina?->setor_id);
                    }),

                Forms\Components\Select::make('setor_id')
                    ->relationship('setor', 'nome')
                    ->disabled()
                    ->dehydrated() // 🔥 ESSENCIAL (senão não salva)
                    ->required(),

                Forms\Components\TextInput::make('titulo')
                    ->required()
                    ->maxLength(255)
                    ->columnSpanFull(),

                Forms\Components\Textarea::make('descricao')
                    ->required()
                    ->rows(4)
                    ->columnSpanFull(),

                Forms\Components\Select::make('prioridade')
                    ->options(PrioridadeOcorrencia::class)
                    ->required()
                    ->default('media'),

                Forms\Components\Select::make('status')
                    ->options(StatusOcorrencia::class)
                    ->default('aberto')
                    ->hiddenOn('create'),

                Forms\Components\FileUpload::make('foto')
                    ->disk(config('maintsys.upload_disk'))
                    ->image()
                    ->directory('ocorrencias')
                    ->columnSpanFull(),
            ]),
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
