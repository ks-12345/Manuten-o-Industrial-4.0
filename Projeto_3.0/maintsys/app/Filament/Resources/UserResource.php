<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;

class UserResource extends Resource
{
    protected static ?string $model = User::class;
    protected static ?string $navigationIcon  = 'heroicon-o-users';
    protected static ?string $navigationGroup = 'Configurações';
    protected static ?string $navigationLabel = 'Usuários';
    protected static ?string $modelLabel      = 'Usuário';
    protected static ?string $pluralModelLabel = 'Usuários';
    protected static ?int    $navigationSort  = 1;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('users.view') ?? false;
    }

    // ─────────────────────────── FORM ────────────────────────────

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Informações Pessoais')
                ->icon('heroicon-o-user')
                ->columns(2)
                ->schema([
                    Forms\Components\TextInput::make('name')
                        ->label('Nome Completo')
                        ->required()
                        ->maxLength(255),

                    Forms\Components\TextInput::make('email')
                        ->label('E-mail')
                        ->email()
                        ->required()
                        ->unique(ignoreRecord: true)
                        ->maxLength(255),

                    Forms\Components\TextInput::make('password')
                        ->label('Senha')
                        ->password()
                        ->revealable()
                        ->dehydrateStateUsing(fn($state) => Hash::make($state))
                        ->dehydrated(fn($state) => filled($state))
                        ->required(fn(string $context) => $context === 'create')
                        ->minLength(8)
                        ->maxLength(255),

                    Forms\Components\FileUpload::make('avatar')
                        ->label('Foto de Perfil')
                        ->image()
                        ->disk('s3')
                        ->directory('avatars')
                        ->imageEditor()
                        ->circleCropper()
                        ->nullable(),
                ]),

            Forms\Components\Section::make('Permissões e Acesso')
                ->icon('heroicon-o-shield-check')
                ->columns(2)
                ->schema([
                    Forms\Components\Select::make('roles')
                        ->label('Perfis de Acesso')
                        ->multiple()
                        ->relationship('roles', 'name')
                        ->options(Role::pluck('name', 'id'))
                        ->preload()
                        ->required(),

                    Forms\Components\Toggle::make('ativo')
                        ->label('Usuário Ativo')
                        ->default(true)
                        ->inline(false),
                ]),

            Forms\Components\Section::make('Acesso Temporário')
                ->icon('heroicon-o-clock')
                ->description('Preencha apenas para usuários com acesso limitado por tempo.')
                ->columns(2)
                ->schema([
                    Forms\Components\Toggle::make('is_temporary')
                        ->label('Usuário Temporário')
                        ->live()
                        ->default(false)
                        ->inline(false),

                    Forms\Components\DateTimePicker::make('data_expiracao')
                        ->label('Data de Expiração')
                        ->native(false)
                        ->minDate(now()->addDay())
                        ->visible(fn(Forms\Get $get) => $get('is_temporary'))
                        ->required(fn(Forms\Get $get) => $get('is_temporary')),
                ]),
        ]);
    }

    // ─────────────────────────── TABLE ───────────────────────────

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('avatar')
                    ->label('')
                    ->circular()
                    ->defaultImageUrl(fn($record) => 'https://ui-avatars.com/api/?name=' . urlencode($record->name) . '&color=7F9CF5&background=EBF4FF'),

                Tables\Columns\TextColumn::make('name')
                    ->label('Nome')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('email')
                    ->label('E-mail')
                    ->searchable()
                    ->copyable(),

                Tables\Columns\TextColumn::make('roles.name')
                    ->label('Perfis')
                    ->badge()
                    ->color(fn($state) => match($state) {
                        'admin'    => 'danger',
                        'professor'=> 'info',
                        'tecnico'  => 'success',
                        default    => 'gray',
                    }),

                Tables\Columns\IconColumn::make('is_temporary')
                    ->label('Temporário')
                    ->boolean()
                    ->trueColor('warning')
                    ->falseColor('gray'),

                Tables\Columns\TextColumn::make('data_expiracao')
                    ->label('Expira em')
                    ->dateTime('d/m/Y H:i')
                    ->color(fn($record) => $record?->isExpired() ? 'danger' : 'warning')
                    ->placeholder('—'),

                Tables\Columns\IconColumn::make('ativo')
                    ->label('Ativo')
                    ->boolean()
                    ->trueColor('success')
                    ->falseColor('danger'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Criado em')
                    ->dateTime('d/m/Y')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('roles')
                    ->label('Perfil')
                    ->relationship('roles', 'name')
                    ->preload(),

                Tables\Filters\TernaryFilter::make('is_temporary')
                    ->label('Temporários')
                    ->placeholder('Todos'),

                Tables\Filters\TernaryFilter::make('ativo')
                    ->label('Ativos')
                    ->placeholder('Todos'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\Action::make('bloquear')
                    ->label('Bloquear')
                    ->icon('heroicon-o-lock-closed')
                    ->color('danger')
                    ->requiresConfirmation()
                    ->visible(fn($record) => $record->ativo)
                    ->action(fn($record) => $record->update(['ativo' => false]))
                    ->successNotificationTitle('Usuário bloqueado.'),

                Tables\Actions\Action::make('desbloquear')
                    ->label('Desbloquear')
                    ->icon('heroicon-o-lock-open')
                    ->color('success')
                    ->requiresConfirmation()
                    ->visible(fn($record) => !$record->ativo)
                    ->action(fn($record) => $record->update(['ativo' => true]))
                    ->successNotificationTitle('Usuário desbloqueado.'),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'edit'   => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}