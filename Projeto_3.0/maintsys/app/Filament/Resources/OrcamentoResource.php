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

    // protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationIcon = 'heroicon-o-currency-dollar';

    // Adicione esta linha para mudar o texto do menu lateral:
    protected static ?string $navigationLabel = 'Orçamento';
    
    // BÔNUS: Adicione estas duas linhas para arrumar os títulos dentro da página também:
    protected static ?string $modelLabel = 'Orçamento';
    protected static ?string $pluralModelLabel = 'Orçamentos';

public static function form(Form $form): Form
{
    return $form
        ->schema([
            Forms\Components\Select::make('solicitacao_peca_id')
                ->relationship('solicitacaoPeca', 'id')
                ->required(),

            Forms\Components\TextInput::make('empresa')
                ->required(),

            Forms\Components\TextInput::make('contato'),

            Forms\Components\TextInput::make('valor')
                ->numeric()
                ->required(),

            Forms\Components\DatePicker::make('prazo_entrega'),

            Forms\Components\Textarea::make('observacoes'),
        ]);
}

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                //
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
