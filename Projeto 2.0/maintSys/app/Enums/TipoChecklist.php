<?php
namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum TipoChecklist: string implements HasLabel
{
    case Inspecao   = 'inspecao';
    case Preventiva = 'preventiva';
    case Corretiva  = 'corretiva';

    public function getLabel(): string
    {
        return match($this) {
            self::Inspecao   => 'Inspeção',
            self::Preventiva => 'Preventiva',
            self::Corretiva  => 'Corretiva',
        };
    }
}