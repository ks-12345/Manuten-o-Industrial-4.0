<?php
namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum StatusCorretiva: string implements HasLabel, HasColor
{
    case EmAndamento = 'em_andamento';
    case Finalizada  = 'finalizada';
    case Cancelada   = 'cancelada';

    public function getLabel(): string
    {
        return match($this) {
            self::EmAndamento => 'Em Andamento',
            self::Finalizada  => 'Finalizada',
            self::Cancelada   => 'Cancelada',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::EmAndamento => 'warning',
            self::Finalizada  => 'success',
            self::Cancelada   => 'danger',
        };
    }
}