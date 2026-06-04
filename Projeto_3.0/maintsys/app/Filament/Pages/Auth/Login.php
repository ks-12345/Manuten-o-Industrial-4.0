<?php

namespace App\Filament\Pages\Auth;

use DanHarrin\LivewireRateLimiting\Exceptions\TooManyRequestsException;
use Filament\Facades\Filament;
use Filament\Forms\Components\Component;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Http\Responses\Auth\Contracts\LoginResponse;
use Filament\Notifications\Notification;
use Filament\Pages\Auth\Login as BaseLogin;
use Illuminate\Validation\ValidationException;

class Login extends BaseLogin
{
    /** Indica se o usuário tem duplo perfil e precisa escolher */
    public bool $precisaEscolherPerfil = false;

    /** Perfil selecionado na tela de escolha */
    public ?string $perfilSelecionado = null;

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                $this->getEmailFormComponent(),
                $this->getPasswordFormComponent(),
                $this->getRememberFormComponent(),
            ])
            ->statePath('data');
    }

    public function authenticate(): ?LoginResponse
    {
        try {
            $this->rateLimit(5);
        } catch (TooManyRequestsException $exception) {
            Notification::make()
                ->title("Muitas tentativas. Tente novamente em {$exception->secondsUntilAvailable}s.")
                ->danger()
                ->send();
            return null;
        }

        $data = $this->form->getState();

        if (!Filament::auth()->attempt([
            'email'    => $data['email'],
            'password' => $data['password'],
        ], $data['remember'] ?? false)) {
            throw ValidationException::withMessages([
                'data.email' => __('filament-panels::pages/auth/login.messages.failed'),
            ]);
        }

        $user = Filament::auth()->user();

        // Verificar se usuário está ativo / não expirado
        if (!$user->ativo || $user->isExpired()) {
            Filament::auth()->logout();
            throw ValidationException::withMessages([
                'data.email' => 'Seu acesso está desativado ou expirou.',
            ]);
        }

        // Se usuário tem AMBOS os papéis professor e técnico → pedir escolha
        if ($user && $user->hasRole(['professor', 'tecnico'])) {
            $this->precisaEscolherPerfil = true;
            return null;
        }

        // Guardar perfil ativo na sessão
        session(['perfil_ativo' => $user->roles->first()?->name]);

        session()->regenerate();

        return app(LoginResponse::class);
    }

    /** Chamado quando o usuário confirma o perfil na tela de seleção */
    public function confirmarPerfil(): ?LoginResponse
    {
        $perfisValidos = ['professor', 'tecnico'];
        if (!in_array($this->perfilSelecionado, $perfisValidos)) {
            Notification::make()->title('Selecione um perfil válido.')->danger()->send();
            return null;
        }

        session(['perfil_ativo' => $this->perfilSelecionado]);
        session()->regenerate();

        return app(LoginResponse::class);
    }

    protected function getEmailFormComponent(): Component
    {
        return TextInput::make('email')
            ->label('E-mail')
            ->email()
            ->required()
            ->autocomplete()
            ->autofocus()
            ->extraInputAttributes(['tabindex' => 1]);
    }
}