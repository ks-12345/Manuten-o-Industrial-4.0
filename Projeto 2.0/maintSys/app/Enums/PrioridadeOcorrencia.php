<?php
namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum PrioridadeOcorrencia: string implements HasLabel, HasColor
{
    case Baixa   = 'baixa';
    case Media   = 'media';
    case Alta    = 'alta';
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
            self::Alta    => 'danger',
            self::Critica => 'danger',
        };
    }

    public function getNivel(): int
    {
        return match($this) {
            self::Baixa   => 1,
            self::Media   => 2,
            self::Alta    => 3,
            self::Critica => 4,
        };
    }
}