<?php
namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasIcon;
use Filament\Support\Contracts\HasLabel;

enum StatusOcorrencia: string implements HasLabel, HasColor, HasIcon
{
    case Aberto       = 'aberto';
    case EmAnalise    = 'em_analise';
    case EmManutencao = 'em_manutencao';
    case Finalizado   = 'finalizado';
    case Cancelado    = 'cancelado';

    public function getLabel(): string
    {
        return match($this) {
            self::Aberto       => 'Aberto',
            self::EmAnalise    => 'Em Análise',
            self::EmManutencao => 'Em Manutenção',
            self::Finalizado   => 'Finalizado',
            self::Cancelado    => 'Cancelado',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::Aberto       => 'warning',
            self::EmAnalise    => 'info',
            self::EmManutencao => 'primary',
            self::Finalizado   => 'success',
            self::Cancelado    => 'danger',
        };
    }

    public function getIcon(): ?string
    {
        return match($this) {
            self::Aberto       => 'heroicon-o-exclamation-circle',
            self::EmAnalise    => 'heroicon-o-magnifying-glass',
            self::EmManutencao => 'heroicon-o-wrench-screwdriver',
            self::Finalizado   => 'heroicon-o-check-circle',
            self::Cancelado    => 'heroicon-o-x-circle',
        };
    }
}