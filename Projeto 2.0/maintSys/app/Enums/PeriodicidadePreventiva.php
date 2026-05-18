<?php
namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum PeriodicidadePreventiva: string implements HasLabel
{
    case Semanal    = 'semanal';
    case Quinzenal  = 'quinzenal';
    case Mensal     = 'mensal';
    case Trimestral = 'trimestral';
    case Semestral  = 'semestral';
    case Anual      = 'anual';

    public function getLabel(): string
    {
        return match($this) {
            self::Semanal    => 'Semanal (7 dias)',
            self::Quinzenal  => 'Quinzenal (15 dias)',
            self::Mensal     => 'Mensal (30 dias)',
            self::Trimestral => 'Trimestral (90 dias)',
            self::Semestral  => 'Semestral (180 dias)',
            self::Anual      => 'Anual (365 dias)',
        };
    }

    public function getDias(): int
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
}