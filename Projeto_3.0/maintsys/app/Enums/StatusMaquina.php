<?php

namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum StatusMaquina: string implements HasLabel, HasColor
{
    case Operando       = 'operando';
    case Atencao        = 'atencao';
    case Quebrada       = 'quebrada';
    case Manutencao     = 'manutencao';
    case AguardandoPeca = 'aguardando_peca';

    public function getLabel(): string
    {
        return match($this) {
            self::Operando       => 'Operando',
            self::Atencao        => 'Atenção',
            self::Quebrada       => 'Quebrada',
            self::Manutencao     => 'Em Manutenção',
            self::AguardandoPeca => 'Aguardando Peça',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::Operando       => 'success',   // verde
            self::Atencao        => 'warning',   // amarelo
            self::Quebrada       => 'danger',    // vermelho
            self::Manutencao     => 'info',      // azul
            self::AguardandoPeca => 'purple',    // roxo (custom)
        };
    }

    /** Cor hexadecimal para o mapa visual */
    public function hexColor(): string
    {
        return match($this) {
            self::Operando       => '#22c55e',
            self::Atencao        => '#eab308',
            self::Quebrada       => '#ef4444',
            self::Manutencao     => '#3b82f6',
            self::AguardandoPeca => '#a855f7',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }
}