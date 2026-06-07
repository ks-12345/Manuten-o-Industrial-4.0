<?php

namespace App\Filament\Resources\MaquinaResource\RelationManagers;

use App\Enums\TipoChecklist;
use App\Models\ChecklistModelo;
use App\Models\Maquina;
use App\Services\ChecklistService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Model;

class ChecklistModeloRelationManager extends RelationManager
{
    protected static string $relationship = 'checklistModelos';
    protected static ?string $title = 'Checklists da Máquina';

    public function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\TextInput::make('nome')
                ->label('Nome')
                ->required()
                ->maxLength(150),

            Forms\Components\Select::make('tipo')
                ->label('Tipo')
                ->options(TipoChecklist::options())
                ->required(),

            Forms\Components\Toggle::make('ativo')
                ->label('Ativo')
                ->default(true)
                ->inline(false),

            Forms\Components\Textarea::make('descricao')
                ->label('Descrição')
                ->rows(3)
                ->columnSpanFull(),
        ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('nome')
            ->columns([
                Tables\Columns\TextColumn::make('nome')->searchable(),
                Tables\Columns\TextColumn::make('tipo')
                    ->badge()
                    ->formatStateUsing(fn ($state) => $state->getLabel())
                    ->color('primary'),
                Tables\Columns\TextColumn::make('perguntas_count')
                    ->label('Perguntas')
                    ->counts('perguntas')
                    ->badge(),
                Tables\Columns\IconColumn::make('ativo')->boolean(),
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make()
                    ->using(function (array $data): Model {
                        /** @var Maquina $maquina */
                        $maquina = $this->getOwnerRecord();

                        $modelo = app(ChecklistService::class)->criarChecklistParaMaquina(
                            $maquina,
                            TipoChecklist::from($data['tipo']),
                            nome: $data['nome']
                        );

                        $modelo->update([
                            'descricao' => $data['descricao'] ?? null,
                            'ativo' => $data['ativo'] ?? true,
                        ]);

                        return $modelo;
                    }),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make()
                    ->before(function (ChecklistModelo $record): void {
                        if ($record->tipo === TipoChecklist::Inspecao) {
                            $dependentes = $this->getOwnerRecord()
                                ->checklistModelos()
                                ->whereIn('tipo', [TipoChecklist::Corretiva->value, TipoChecklist::Preventiva->value])
                                ->exists();

                            abort_if($dependentes, 422, 'Não é permitido remover a inspeção enquanto existirem checklists corretivos ou preventivos.');
                        }
                    }),
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }
}
