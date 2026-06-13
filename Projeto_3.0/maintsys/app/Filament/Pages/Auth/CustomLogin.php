<?php

namespace App\Filament\Pages\Auth;

use Filament\Actions\Action;
use Filament\Forms\Form;
use Filament\Pages\Auth\Login as BaseLogin;
use Illuminate\Contracts\Support\Htmlable;

class CustomLogin extends BaseLogin
{
    /**
     * Título principal da página
     */
    public function getHeading(): string|Htmlable
    {
        return 'Sistema de Gestão de Manutenção';
    }

    /**
     * Subtítulo abaixo do título
     */
protected function getSignUpAction(): ?Action
{
    return null;
}

    /**
     * Personaliza o botão de login
     */
    protected function getAuthenticateFormAction(): Action
    {
        return parent::getAuthenticateFormAction()
            ->label('Entrar')
            ->icon('heroicon-o-arrow-right-on-rectangle')
            ->color('primary');
    }

    /**
     * Remove o botão de cadastro
     */
    protected function getRegisterAction(): ?Action
    {
        return null;
    }

    /**
     * Personaliza o formulário
     */
    public function form(Form $form): Form
    {
        return $form->schema([
            $this->getEmailFormComponent()
                ->label('E-mail')
                ->placeholder('Digite seu e-mail'),

            $this->getPasswordFormComponent()
                ->label('Senha')
                ->placeholder('Digite sua senha'),

            $this->getRememberFormComponent(),
        ]);
    }
}