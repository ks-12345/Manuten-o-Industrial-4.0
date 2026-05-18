<?php
namespace App\Enums;

enum StatusMaquina: string
{
    case Operando   = 'operando';
    case Atencao    = 'atencao';
    case Quebrada   = 'quebrada';
    case Manutencao = 'manutencao';

    public function getLabel(): string
    {
        return match($this) {
            self::Operando   => 'Operando',
            self::Atencao    => 'Atenção',
            self::Quebrada   => 'Quebrada',
            self::Manutencao => 'Em Manutenção',
        };
    }

    public function getCor(): string
    {
        return match($this) {
            self::Operando   => '#22c55e',
            self::Atencao    => '#eab308',
            self::Quebrada   => '#ef4444',
            self::Manutencao => '#3b82f6',
        };
    }

    public function getCorTailwind(): string
    {
        return match($this) {
            self::Operando   => 'bg-green-500',
            self::Atencao    => 'bg-yellow-500',
            self::Quebrada   => 'bg-red-500',
            self::Manutencao => 'bg-blue-500',
        };
    }

    public function getFilamentColor(): string
    {
        return match($this) {
            self::Operando   => 'success',
            self::Atencao    => 'warning',
            self::Quebrada   => 'danger',
            self::Manutencao => 'info',
        };
    }
}