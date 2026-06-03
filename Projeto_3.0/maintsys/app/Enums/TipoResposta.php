<?php

namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum TipoResposta: string implements HasLabel
{
    case SimNao      = 'sim_nao';
    case OkProblema  = 'ok_problema';
    case Texto       = 'texto';
    case Observacao  = 'observacao';
    case Foto        = 'foto';

    public function getLabel(): string
    {
        return match($this) {
            self::SimNao     => 'Sim / Não',
            self::OkProblema => 'OK / Problema',
            self::Texto      => 'Texto Livre',
            self::Observacao => 'Observação',
            self::Foto       => 'Foto',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}