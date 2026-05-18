<?php
namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum StatusPreventiva: string implements HasLabel, HasColor
{
    case Pendente   = 'pendente';
    case Realizada  = 'realizada';
    case Atrasada   = 'atrasada';
    case Cancelada  = 'cancelada';

    public function getLabel(): string
    {
        return match($this) {
            self::Pendente  => 'Pendente',
            self::Realizada => 'Realizada',
            self::Atrasada  => 'Atrasada',
            self::Cancelada => 'Cancelada',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::Pendente  => 'info',
            self::Realizada => 'success',
            self::Atrasada  => 'danger',
            self::Cancelada => 'gray',
        };
    }
}