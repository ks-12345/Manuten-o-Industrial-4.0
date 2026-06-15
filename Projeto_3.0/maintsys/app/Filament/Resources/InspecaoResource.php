<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InspecaoResource\Pages;
use App\Models\Inspecao;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class InspecaoResource extends Resource
{
    protected static ?string $model = Inspecao::class;

    protected static ?string $navigationIcon = 'heroicon-o-magnifying-glass';
    protected static ?string $navigationGroup = 'Operações';
    protected static ?string $navigationLabel = 'Inspeções';
    protected static ?string $modelLabel = 'Inspeção';
    protected static ?int $navigationSort = 2;

    public static function canAccess(): bool
    {
        // Evita erro de tipagem estática; acesso real deve ser controlado via Policy/Permissions.
        return Auth::check();
    }

    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery()->with(['ocorrencia.maquina', 'tecnico']);
        $user = Auth::user();

        if (!$user) {
            return $query->whereRaw('1 = 0');
        }

        // Mantém o filtro existente: admins veem tudo; técnicos veem apenas suas inspeções.
        if (!method_exists($user, 'hasRole') || !$user->hasRole('admin')) {
            $query->where('tecnico_id', $user->id);
        }

        return $query;
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('ocorrencia.codigo')
                    ->label('Ocorrência')
                    ->badge()
                    ->color('primary'),

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

                // NOVA COLUNA VISUAL: Mostra na listagem se a inspeção gerou uma corretiva
                Tables\Columns\IconColumn::make('necessita_corretiva')
                    ->label('Gerou Corretiva?')
                    ->boolean()
                    ->trueIcon('heroicon-o-exclamation-triangle')
                    ->falseIcon('heroicon-o-check-badge')
                    ->trueColor('warning')
                    ->falseColor('success')
                    ->placeholder('Em andamento'),
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
            'index' => Pages\ListInspecaos::route('/'),
            'executar' => Pages\ExecutarInspecao::route('/{record}/executar'),
        ];
    }
}