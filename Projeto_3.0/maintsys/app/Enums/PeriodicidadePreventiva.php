<?php

namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum PeriodicidadePreventiva: string implements HasLabel
{
    case Semanal     = 'semanal';
    case Quinzenal   = 'quinzenal';
    case Mensal      = 'mensal';
    case Trimestral  = 'trimestral';
    case Semestral   = 'semestral';
    case Anual       = 'anual';

    public function getLabel(): string
    {
        return match($this) {
            self::Semanal    => 'Semanal',
            self::Quinzenal  => 'Quinzenal',
            self::Mensal     => 'Mensal',
            self::Trimestral => 'Trimestral',
            self::Semestral  => 'Semestral',
            self::Anual      => 'Anual',
        };
    }

    /** Retorna número de dias entre preventivas */
    public function diasIntervalo(): int
    {
        return match($this) {
            self::Semanal    => 7,
            self::Quinzenal  => 15,
            self::Mensal     => 30,
            self::Trimestral => 90,
            self::Semestral  => 180,
            self::Anual      => 365,
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}