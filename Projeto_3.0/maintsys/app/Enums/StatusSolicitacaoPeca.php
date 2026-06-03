<?php

namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum StatusSolicitacaoPeca: string implements HasLabel, HasColor
{
    case Pendente       = 'pendente';
    case EmCotacao      = 'em_cotacao';
    case Aprovado       = 'aprovado';
    case AguardandoPeca = 'aguardando_peca';
    case PecaRecebida   = 'peca_recebida';
    case Finalizado     = 'finalizado';

    public function getLabel(): string
    {
        return match($this) {
            self::Pendente       => 'Pendente',
            self::EmCotacao      => 'Em Cotação',
            self::Aprovado       => 'Aprovado',
            self::AguardandoPeca => 'Aguardando Peça',
            self::PecaRecebida   => 'Peça Recebida',
            self::Finalizado     => 'Finalizado',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::Pendente       => 'warning',
            self::EmCotacao      => 'info',
            self::Aprovado       => 'success',
            self::AguardandoPeca => 'orange',
            self::PecaRecebida   => 'primary',
            self::Finalizado     => 'success',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}