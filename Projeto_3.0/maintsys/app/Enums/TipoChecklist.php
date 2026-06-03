<?php

namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum TipoChecklist: string implements HasLabel
{
    case Inspecao   = 'inspecao';
    case Corretiva  = 'corretiva';
    case Preventiva = 'preventiva';

    public function getLabel(): string
    {
        return match($this) {
            self::Inspecao   => 'Inspeção',
            self::Corretiva  => 'Corretiva',
            self::Preventiva => 'Preventiva',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}