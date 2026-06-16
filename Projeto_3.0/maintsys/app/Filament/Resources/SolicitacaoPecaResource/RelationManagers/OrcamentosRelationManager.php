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

    // Bug 3 corrigido: garante que a aba de orçamentos sempre seja visível
    public static function canViewAny(): bool
    {
        return true;
    }

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
            ->filters([])
            ->headerActions([
                Tables\Actions\Action::make('cadastrar_orcamentos')
                    ->label('Cadastrar Orçamentos')
                    ->icon('heroicon-o-plus-circle')
                    ->color('primary')
                    ->visible(
                        fn () => in_array(
                            $this->ownerRecord->status,
                            [
                                StatusSolicitacaoPeca::Pendente,
                                StatusSolicitacaoPeca::EmCotacao,
                            ]
                        )
                        && $this->ownerRecord->totalOrcamentos() < 3
                    )
                    ->form([
                        Forms\Components\Repeater::make('orcamentos')
                            ->label('Orçamentos')
                            ->schema([
                                Forms\Components\TextInput::make('empresa')
                                    ->label('Empresa / Fornecedor')
                                    ->required(),

                                Forms\Components\TextInput::make('contato')
                                    ->label('Contato'),

                                Forms\Components\TextInput::make('valor')
                                    ->label('Valor')
                                    ->numeric()
                                    ->prefix('R$')
                                    ->required(),

                                Forms\Components\TextInput::make('prazo_entrega')
                                    ->label('Prazo de Entrega')
                                    ->numeric()
                                    ->suffix('dias'),

                                Forms\Components\Textarea::make('observacoes')
                                    ->label('Observações')
                                    ->rows(2),

                                Forms\Components\FileUpload::make('arquivo')
                                    ->label('PDF do Orçamento')
                                    ->disk('s3')
                                    ->directory('orcamentos')
                                    ->acceptedFileTypes(['application/pdf']),
                            ])
                            ->minItems(1)
                            ->maxItems(fn () => 3 - $this->ownerRecord->totalOrcamentos())
                            ->defaultItems(1)
                            ->addActionLabel('Adicionar outro orçamento'),
                    ])
                    ->action(function (array $data): void {
                        foreach ($data['orcamentos'] as $orcamento) {
                            $this->ownerRecord->orcamentos()->create([
                                'empresa'       => $orcamento['empresa'],
                                'contato'       => $orcamento['contato'] ?? null,
                                'valor'         => $orcamento['valor'],
                                'prazo_entrega' => $orcamento['prazo_entrega'] ?? null,
                                'observacoes'   => $orcamento['observacoes'] ?? null,
                                'arquivo'       => $orcamento['arquivo'] ?? null,
                            ]);
                        }

                        if ($this->ownerRecord->status === StatusSolicitacaoPeca::Pendente) {
                            $this->ownerRecord->update([
                                'status' => StatusSolicitacaoPeca::EmCotacao,
                            ]);
                        }

                        Notification::make()
                            ->success()
                            ->title('Orçamentos cadastrados com sucesso!')
                            ->send();
                    }),
            ])
            ->actions([
                Tables\Actions\EditAction::make()
                    ->visible(fn (Orcamento $record) => ! $record->aprovado),

                // Bug 2 corrigido também aqui: botão de aprovar na relation manager
                Tables\Actions\Action::make('aprovar')
                    ->label('Aprovar')
                    ->icon('heroicon-o-check-badge')
                    ->color('success')
                    ->requiresConfirmation()
                    ->visible(fn (Orcamento $record) => ! $record->aprovado)
                    ->action(fn (Orcamento $record) => $record->aprovar(Auth::user())),

                Tables\Actions\DeleteAction::make()
                    ->visible(fn (Orcamento $record) => ! $record->aprovado),
            ])
            ->bulkActions([]);
    }
}