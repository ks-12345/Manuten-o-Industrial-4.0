<?php

namespace App\Filament\Resources;

use App\Filament\Resources\OrcamentoResource\Pages;
use App\Models\Orcamento;
use App\Models\SolicitacaoPeca;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class OrcamentoResource extends Resource
{
    protected static ?string $model           = Orcamento::class;
    protected static ?string $navigationIcon  = 'heroicon-o-currency-dollar';
    protected static ?string $navigationLabel = 'Orçamentos';
    protected static ?string $modelLabel      = 'Orçamento';
    protected static ?string $pluralModelLabel = 'Orçamentos';

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Select::make('solicitacao_peca_id')
                ->label('Peça / Ordem de Serviço')
                ->options(
                    SolicitacaoPeca::with('inspecao.ocorrencia')
                        ->get()
                        ->mapWithKeys(fn (SolicitacaoPeca $s) => [
                            $s->id => $s->nome_peca . ' — OS: ' . ($s->inspecao?->ocorrencia?->codigo ?? 'S/OS'),
                        ])
                )
                ->searchable()
                ->required(),

            Forms\Components\TextInput::make('empresa')
                ->required(),

            Forms\Components\TextInput::make('contato'),

            Forms\Components\TextInput::make('valor')
                ->numeric()
                ->required(),

            Forms\Components\TextInput::make('prazo_entrega')
                ->label('Prazo de Entrega (em dias)')
                ->numeric()
                ->integer()
                ->placeholder('Ex: 15')
                ->suffix('dias'),

            Forms\Components\Textarea::make('observacoes'),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('solicitacaoPeca.inspecao.ocorrencia.codigo')
                    ->label('OS')
                    ->badge()
                    ->color('primary'),

                Tables\Columns\TextColumn::make('solicitacaoPeca.nome_peca')
                    ->label('Peça')
                    ->searchable(),

                Tables\Columns\TextColumn::make('empresa')
                    ->label('Empresa')
                    ->searchable(),

                Tables\Columns\TextColumn::make('valor')
                    ->money('BRL')
                    ->sortable(),

                Tables\Columns\TextColumn::make('prazo_entrega')
                    ->label('Prazo')
                    ->suffix(' dias')
                    ->placeholder('—'),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->default('pendente')
                    ->formatStateUsing(fn ($state) => match ($state) {
                        'aprovado' => 'Aprovado',
                        'negado'   => 'Negado',
                        default    => 'Pendente',
                    })
                    ->color(fn ($state) => match ($state) {
                        'aprovado' => 'success',
                        'negado'   => 'danger',
                        default    => 'warning',
                    }),

                Tables\Columns\TextColumn::make('aprovadoPor.name')
                    ->label('Avaliado por')
                    ->placeholder('—')
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('aprovado_em')
                    ->label('Avaliado em')
                    ->dateTime('d/m/Y H:i')
                    ->placeholder('—')
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->defaultSort('created_at', 'desc')
            ->actions([
                Tables\Actions\Action::make('aprovar')
                    ->label('Aprovar')
                    ->icon('heroicon-o-check-badge')
                    ->color('success')
                    ->requiresConfirmation()
                    ->modalHeading('Aprovar Orçamento')
                    ->modalDescription(fn (Orcamento $record) =>
                        'Aprovar o orçamento de R$ ' . number_format($record->valor, 2, ',', '.') .
                        ' da empresa "' . $record->empresa . '"? Os demais orçamentos desta solicitação serão marcados como Negado automaticamente.'
                    )
                    ->modalSubmitActionLabel('Sim, aprovar')
                    ->visible(fn (Orcamento $record) => $record->isPendente())
                    ->action(function (Orcamento $record) {
                        $record->aprovar(Auth::user());

                        Notification::make()
                            ->success()
                            ->title('Orçamento aprovado!')
                            ->body('Os demais orçamentos desta solicitação foram negados automaticamente.')
                            ->send();
                    }),

                Tables\Actions\Action::make('negar')
                    ->label('Negar')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->requiresConfirmation()
                    ->modalHeading('Negar Orçamento')
                    ->modalDescription('Tem certeza que deseja negar este orçamento?')
                    ->modalSubmitActionLabel('Sim, negar')
                    ->visible(fn (Orcamento $record) => $record->isPendente())
                    ->action(function (Orcamento $record) {
                        $record->negar(Auth::user());

                        Notification::make()
                            ->warning()
                            ->title('Orçamento negado.')
                            ->send();
                    }),

                Tables\Actions\EditAction::make()
                    ->visible(fn (Orcamento $record) => $record->isPendente()),

                Tables\Actions\DeleteAction::make()
                    ->visible(fn (Orcamento $record) => $record->isPendente()),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListOrcamentos::route('/'),
            'create' => Pages\CreateOrcamento::route('/create'),
            'edit'   => Pages\EditOrcamento::route('/{record}/edit'),
        ];
    }
}