<?php

namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum PrioridadeOcorrencia: string implements HasLabel, HasColor
{
    case Baixa  = 'baixa';
    case Media  = 'media';
    case Alta   = 'alta';
    case Critica = 'critica';

    public function getLabel(): string
    {
        return match($this) {
            self::Baixa   => 'Baixa',
            self::Media   => 'Média',
            self::Alta    => 'Alta',
            self::Critica => 'Crítica',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::Baixa   => 'success',
            self::Media   => 'warning',
            self::Alta    => 'orange',
            self::Critica => 'danger',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}