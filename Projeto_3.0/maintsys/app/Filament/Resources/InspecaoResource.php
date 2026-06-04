<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InspecaoResource\Pages;
use App\Models\Inspecao;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class InspecaoResource extends Resource
{
    protected static ?string $model           = Inspecao::class;
    protected static ?string $navigationIcon  = 'heroicon-o-magnifying-glass';
    protected static ?string $navigationGroup = 'Operações';
    protected static ?string $navigationLabel = 'Inspeções';
    protected static ?string $modelLabel      = 'Inspeção';
    protected static ?int    $navigationSort  = 2;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('inspecoes.view') ?? false;
    }

    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery()->with(['ocorrencia.maquina', 'tecnico']);
        $user  = Auth::user();

        if (!$user->hasRole('admin')) {
            $query->where('tecnico_id', $user->id);
        }

        return $query;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make()->schema([
                Forms\Components\Textarea::make('diagnostico')
                    ->label('Diagnóstico')
                    ->rows(4)
                    ->required(),

                Forms\Components\Textarea::make('observacoes')
                    ->label('Observações')
                    ->rows(3),

                Forms\Components\Radio::make('necessita_peca')
                    ->label('A máquina necessita de substituição de peça?')
                    ->boolean()
                    ->inline()
                    ->required(),
            ]),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('ocorrencia.codigo')
                    ->label('Ocorrência')
                    ->badge()->color('primary'),

                Tables\Columns\TextColumn::make('ocorrencia.maquina.nome')
                    ->label('Máquina')
                    ->searchable(),

                Tables\Columns\TextColumn::make('tecnico.name')
                    ->label('Técnico'),

                Tables\Columns\TextColumn::make('inicio')
                    ->label('Iniciada em')
                    ->dateTime('d/m/Y H:i'),

                Tables\Columns\TextColumn::make('fim')
                    ->label('Finalizada em')
                    ->dateTime('d/m/Y H:i')
                    ->placeholder('Em andamento'),

                Tables\Columns\IconColumn::make('necessita_peca')
                    ->label('Precisa Peça?')
                    ->boolean()
                    ->trueIcon('heroicon-o-check-circle')
                    ->falseIcon('heroicon-o-x-circle')
                    ->trueColor('danger')
                    ->falseColor('success'),
            ])
            ->actions([
                Tables\Actions\Action::make('executar')
                    ->label('Executar')
                    ->icon('heroicon-o-play')
                    ->color('primary')
                    ->url(fn($record) => Pages\ExecutarInspecao::getUrl(['record' => $record]))
                    ->visible(fn($record) => !$record->estaFinalizada()),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index'    => Pages\ListInspecaos::route('/'),
            'executar' => Pages\ExecutarInspecao::route('/{record}/executar'),
        ];
    }
}