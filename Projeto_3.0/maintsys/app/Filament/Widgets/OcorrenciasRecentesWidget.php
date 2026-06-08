<?php

namespace App\Filament\Widgets;

use App\Enums\StatusOcorrencia;
use App\Filament\Resources\OcorrenciaResource;
use App\Models\Ocorrencia;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use Illuminate\Support\Facades\Auth;

class OcorrenciasRecentesWidget extends BaseWidget
{
    protected static ?string $heading    = 'Ocorrências Recentes';
    protected static ?int    $sort       = 2;
    protected int | string | array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        $user  = Auth::user();
        $query = Ocorrencia::with(['maquina', 'professor', 'tecnico'])
            ->where('status', '!=', StatusOcorrencia::Concluida->value)
            ->latest();

        if ($user->hasRole('professor') && !$user->hasRole('admin')) {
            $query->where('professor_id', $user->id);
        }

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('codigo')
                    ->label('Código')->badge()->color('primary'),
                Tables\Columns\TextColumn::make('titulo')
                    ->label('Título')->limit(30),
                Tables\Columns\TextColumn::make('maquina.nome')
                    ->label('Máquina'),
                Tables\Columns\TextColumn::make('prioridade')->label('Prioridade')->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())->color(fn($s) => $s->getColor()),
                Tables\Columns\TextColumn::make('status')->label('Status')->badge()
                    ->formatStateUsing(fn($s) => $s->getLabel())->color(fn($s) => $s->getColor()),
                Tables\Columns\TextColumn::make('created_at')->label('Aberta em')->dateTime('d/m/Y H:i'),
            ])
            ->actions([
                Tables\Actions\Action::make('ver')
                    ->label('Ver')
                    ->icon('heroicon-o-eye')
                    ->url(fn($record) => OcorrenciaResource::getUrl('view', ['record' => $record])),
            ])
            ->paginated([5, 10]);
    }
}
