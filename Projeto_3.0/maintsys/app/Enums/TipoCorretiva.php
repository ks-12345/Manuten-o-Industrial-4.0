<?php

namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum TipoCorretiva: string implements HasLabel
{
    case OrigemOcorrencia = 'origem_ocorrencia';
    case Direta           = 'direta';

    public function getLabel(): string
    {
        return match($this) {
            self::OrigemOcorrencia => 'Originada de Ocorrência',
            self::Direta           => 'Corretiva Direta',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}