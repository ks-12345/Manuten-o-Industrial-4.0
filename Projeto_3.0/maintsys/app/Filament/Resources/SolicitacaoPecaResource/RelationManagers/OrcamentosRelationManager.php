<?php

namespace App\Filament\Resources\SolicitacaoPecaResource\RelationManagers;

use App\Enums\StatusSolicitacaoPeca;
use App\Models\Orcamento;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class OrcamentosRelationManager extends RelationManager
{
    protected static string $relationship = 'orcamentos';
    protected static ?string $title       = 'Orçamentos (máx. 3)';

    public function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make()->columns(2)->schema([
                Forms\Components\TextInput::make('empresa')
                    ->label('Empresa / Fornecedor')
                    ->required()
                    ->maxLength(150),

                Forms\Components\TextInput::make('contato')
                    ->label('Contato')
                    ->maxLength(150)
                    ->nullable(),

                Forms\Components\TextInput::make('valor')
                    ->label('Valor (R$)')
                    ->numeric()
                    ->prefix('R$')
                    ->required()
                    ->minValue(0.01),

                Forms\Components\TextInput::make('prazo_entrega')
                    ->label('Prazo de Entrega (dias)')
                    ->numeric()
                    ->nullable()
                    ->suffix('dias'),

                Forms\Components\Textarea::make('observacoes')
                    ->label('Observações')
                    ->rows(3)
                    ->columnSpanFull(),

                Forms\Components\FileUpload::make('arquivo')
                    ->label('PDF do Orçamento')
                    ->disk('s3')
                    ->directory('orcamentos')
                    ->acceptedFileTypes(['application/pdf'])
                    ->maxSize(10240)
                    ->columnSpanFull()
                    ->nullable(),
            ]),
        ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('empresa')
            ->columns([
                Tables\Columns\TextColumn::make('empresa')
                    ->label('Empresa')
                    ->searchable(),

                Tables\Columns\TextColumn::make('valor')
                    ->label('Valor')
                    ->money('BRL')
                    ->sortable(),

                Tables\Columns\TextColumn::make('prazo_entrega')
                    ->label('Prazo')
                    ->suffix(' dias')
                    ->placeholder('—'),

                Tables\Columns\IconColumn::make('aprovado')
                    ->label('Aprovado')
                    ->boolean()
                    ->trueColor('success')
                    ->falseColor('gray'),

                Tables\Columns\TextColumn::make('aprovado_em')
                    ->label('Aprovado em')
                    ->dateTime('d/m/Y H:i')
                    ->placeholder('—'),
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make()
                    ->label('Adicionar Orçamento')
                    ->before(function () {
                        if ($this->ownerRecord->totalOrcamentos() >= 3) {
                            Notification::make()
                                ->danger()
                                ->title('Máximo de 3 orçamentos por solicitação.')
                                ->send();
                            $this->halt();
                        }
                    }),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),

                Tables\Actions\Action::make('aprovar')
                    ->label('Aprovar')
                    ->icon('heroicon-o-check-badge')
                    ->color('success')
                    ->requiresConfirmation()
                    ->modalDescription('Este orçamento será aprovado e os demais serão reprovados automaticamente.')
                    ->visible(fn($record) => !$record->aprovado
                        && Auth::user()->hasPermissionTo('orcamentos.aprovar'))
                    ->action(function (Orcamento $record) {
                        $record->aprovar(Auth::user());

                        // Atualizar status da solicitação para aguardando peça
                        $record->solicitacaoPeca->update([
                            'status' => StatusSolicitacaoPeca::AguardandoPeca->value,
                        ]);

                        // Registrar no histórico
                        \App\Models\Historico::registrar(
                            $record->solicitacaoPeca->inspecao->ocorrencia,
                            \App\Models\Historico::ACAO_ORCAMENTO_APROVADO,
                            "Orçamento aprovado: {$record->empresa} — R$ " . number_format($record->valor, 2, ',', '.'),
                        );

                        Notification::make()->success()->title('Orçamento aprovado!')->send();
                    }),

                Tables\Actions\DeleteAction::make()
                    ->visible(fn($record) => !$record->aprovado),
            ]);
    }
}