<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CorretivaResource\Pages;
use App\Models\Corretiva;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CorretivaResource extends Resource
{
    protected static ?string $model = Corretiva::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
{
    return $form
        ->schema([

            Forms\Components\Select::make('ocorrencia_id')
                ->label('Ocorrência')
                ->relationship('ocorrencia', 'titulo') // troque "titulo" pelo campo correto
                ->searchable()
                ->required(),

            Forms\Components\Textarea::make('descricao')
                ->label('Descrição'),

            Forms\Components\DatePicker::make('data_execucao')
                ->label('Data da Execução'),
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
                Tables\Actions\Action::make('executar')
                    ->label('Executar')
                    ->icon('heroicon-o-wrench-screwdriver')
                    ->color('warning')
                    ->url(fn (Corretiva $record): string => static::getUrl('executar', ['record' => $record])),
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
            'index' => Pages\ListCorretivas::route('/'),
            'create' => Pages\CreateCorretiva::route('/create'),
            'executar' => Pages\Executar::route('/{record}/executar'),
            'edit' => Pages\EditCorretiva::route('/{record}/edit'),
        ];
    }
}
