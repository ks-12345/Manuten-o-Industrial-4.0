<?php

namespace App\Filament\Resources;

use App\Enums\StatusOcorrencia;
use App\Enums\StatusSolicitacaoPeca;
use App\Filament\Resources\SolicitacaoPecaResource\Pages;
use App\Filament\Resources\SolicitacaoPecaResource\RelationManagers\OrcamentosRelationManager;
use App\Models\SolicitacaoPeca;
use Filament\Forms\Form;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;


class SolicitacaoPecaResource extends Resource
{
    protected static ?string $model           = SolicitacaoPeca::class;
    protected static ?string $navigationIcon  = 'heroicon-o-cube';
    protected static ?string $navigationGroup = 'Operações';
    protected static ?string $navigationLabel = 'Solicitações de Peças';
    protected static ?string $modelLabel      = 'Solicitação de Peça';
    protected static ?int    $navigationSort  = 3;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('solicitacoes_pecas.view') ?? false;
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                
Tables\Columns\TextColumn::make('maquina.nome')
    ->label('Máquina')
    ->searchable()
    ->description(fn (SolicitacaoPeca $record) =>
        $record->inspecao?->ocorrencia?->codigo
    ),

                Tables\Columns\TextColumn::make('nome_peca')
                    ->label('Peça Solicitada')
                    ->searchable(),

                Tables\Columns\TextColumn::make('quantidade')
                    ->label('Qtd')
                    ->badge()
                    ->color('info'),

Tables\Columns\TextColumn::make('status')
    ->label('Status')
    ->badge()
    ->formatStateUsing(fn ($state) => $state->getLabel())
    ->color(fn ($state) => $state->getColor()),

                Tables\Columns\TextColumn::make('orcamentos_count')
                    ->label('Orçamentos')
                    ->counts('orcamentos')
                    ->badge()
                    ->color('gray'),

                Tables\Columns\TextColumn::make('valor_total_aprovado')
                    ->label('Valor Aprovado')
                    ->money('BRL')
                    ->placeholder('—'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Solicitada em')
                    ->dateTime('d/m/Y')
                    ->sortable(),
            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Status')
                    ->options(StatusSolicitacaoPeca::options()),
            ])
            ->actions([
                Tables\Actions\Action::make('orcamentos')
    ->label('Ver Orçamentos')
    ->icon('heroicon-o-currency-dollar')
    ->color('warning')
    ->url(fn (SolicitacaoPeca $record) =>
        static::getUrl('view', ['record' => $record])
    ),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\Action::make('marcar_recebida')
                    ->label('Peça Recebida')
                    ->icon('heroicon-o-check-badge')
                    ->color('success')
                    ->requiresConfirmation()
                    ->visible(fn (SolicitacaoPeca $record) =>
    $record->status === StatusSolicitacaoPeca::AguardandoPeca
)
                    ->action(function ($record) {
                        $record->update([
                            'status'          => StatusSolicitacaoPeca::PecaRecebida->value,
                            'peca_recebida_em'=> now(),
                        ]);
                        // Atualizar status da ocorrência para EmCorretiva
                        if ($record->inspecao?->ocorrencia) {
                            app(\App\Services\OcorrenciaService::class)->transicionarStatus(
                                $record->inspecao->ocorrencia,
                                StatusOcorrencia::Corretiva,
                                Auth::user()
                            );
                        }
                        \Filament\Notifications\Notification::make()
                            ->success()->title('Peça recebida registrada!')->send();
                    }),
            ]);
            
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist->schema([
            Infolists\Components\Section::make('Solicitação')->columns(3)->schema([
                Infolists\Components\TextEntry::make('maquina.nome')->label('Máquina'),
                Infolists\Components\TextEntry::make('nome_peca')->label('Peça'),
                Infolists\Components\TextEntry::make('quantidade')->label('Quantidade'),
                Infolists\Components\TextEntry::make('referencia')->label('Referência')->placeholder('—'),
                Infolists\Components\TextEntry::make('status')
                    ->label('Status')
                    ->badge()
                    ->getStateUsing(
                        fn (SolicitacaoPeca $record): StatusSolicitacaoPeca => $record->status
                    )
                    ->formatStateUsing(
                        fn (StatusSolicitacaoPeca $state): string => $state->getLabel()
                    )
                    ->color(
                        fn (StatusSolicitacaoPeca $state): string => $state->getColor()
                    ),
                Infolists\Components\TextEntry::make('valor_total_aprovado')->label('Valor Aprovado')->money('BRL')->placeholder('—'),
                Infolists\Components\TextEntry::make('descricao')->label('Descrição')->columnSpanFull()->placeholder('—'),
            ]),
        ]);
    }

    public static function getRelationManagers(): array
    {
        return [OrcamentosRelationManager::class];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListSolicitacaoPecas::route('/'),
            'view'  => Pages\ViewSolicitacaoPeca::route('/{record}'),
        ];
    }
}
