<?php

namespace App\Filament\Resources;

use App\Filament\Resources\OrcamentoResource\Pages;
use App\Filament\Resources\OrcamentoResource\RelationManagers;
use App\Models\Orcamento;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class OrcamentoResource extends Resource
{
    protected static ?string $model = Orcamento::class;

    protected static ?string $navigationIcon = 'heroicon-o-currency-dollar';
    protected static bool $shouldRegisterNavigation = false;
    // protected static ?string $navigationLabel = 'Orçamento';

    protected static ?string $modelLabel = 'Orçamento';

    protected static ?string $pluralModelLabel = 'Orçamentos';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
Forms\Components\Select::make('solicitacao_peca_id')
    ->relationship('solicitacaoPeca', 'nome_peca')
    ->preload()
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
        ->label('OS'),

    Tables\Columns\TextColumn::make('solicitacaoPeca.nome_peca')
        ->label('Peça'),

    Tables\Columns\TextColumn::make('empresa')
        ->label('Empresa'),

    Tables\Columns\TextColumn::make('valor')
        ->money('BRL'),

    Tables\Columns\IconColumn::make('aprovado')
        ->boolean(),
])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListOrcamentos::route('/'),
            'create' => Pages\CreateOrcamento::route('/create'),
            'edit' => Pages\EditOrcamento::route('/{record}/edit'),
        ];
    }
}

