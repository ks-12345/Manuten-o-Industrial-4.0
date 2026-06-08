<?php

namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum StatusOcorrencia: string implements HasLabel, HasColor
{
    case Aberta               = 'aberta';
    case Assumida             = 'assumida';
    case EmInspecao           = 'em_inspecao';
    case Corretiva           = 'corretiva';
    case AguardandoOrcamento = 'aguardando_orcamento';
    case Concluida           = 'concluida';

    public function getLabel(): string
    {
        return match ($this) {
            self::Aberta               => 'Aberta',
            self::Assumida             => 'Assumida',
            self::EmInspecao           => 'Em Inspeção',
            self::Corretiva           => 'Corretiva',
            self::AguardandoOrcamento => 'Aguardando Orçamento',
            self::Concluida           => 'Concluída',
        };
    }

    public function getColor(): string|array|null
    {
        return match ($this) {
            self::Aberta               => 'warning',
            self::Assumida             => 'info',
            self::EmInspecao           => 'primary',
            self::Corretiva           => 'success',
            self::AguardandoOrcamento => 'orange',
            self::Concluida           => 'success',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn ($case) => [$case->value => $case->getLabel()])
            ->all();
    }

    /** Fluxo permitido de transições (state machine oficial) */
    public function transicoesPermitidas(): array
    {
        return match ($this) {
            self::Aberta => [self::Assumida],
            self::Assumida => [self::EmInspecao],
            self::EmInspecao => [self::Corretiva, self::AguardandoOrcamento],
            self::AguardandoOrcamento => [self::Corretiva],
            self::Corretiva => [self::Concluida],
            self::Concluida => [],
        };
    }
}

