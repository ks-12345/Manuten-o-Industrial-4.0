<?php

namespace App\Enums;

use Filament\Support\Contracts\HasColor;
use Filament\Support\Contracts\HasLabel;

enum StatusOcorrencia: string implements HasLabel, HasColor
{
    case Aberta              = 'aberta';
    case EmAnalise           = 'em_analise';
    case AguardandoOrcamento = 'aguardando_orcamento';
    case AguardandoPeca      = 'aguardando_peca';
    case EmCorretiva         = 'em_corretiva';
    case Finalizada          = 'finalizada';
    case Cancelada           = 'cancelada';

    public function getLabel(): string
    {
        return match($this) {
            self::Aberta              => 'Aberta',
            self::EmAnalise           => 'Em Análise',
            self::AguardandoOrcamento => 'Aguardando Orçamento',
            self::AguardandoPeca      => 'Aguardando Peça',
            self::EmCorretiva         => 'Em Corretiva',
            self::Finalizada          => 'Finalizada',
            self::Cancelada           => 'Cancelada',
        };
    }

    public function getColor(): string|array|null
    {
        return match($this) {
            self::Aberta              => 'warning',
            self::EmAnalise           => 'info',
            self::AguardandoOrcamento => 'orange',
            self::AguardandoPeca      => 'purple',
            self::EmCorretiva         => 'primary',
            self::Finalizada          => 'success',
            self::Cancelada           => 'danger',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())->mapWithKeys(
            fn ($case) => [$case->value => $case->getLabel()]
        )->all();
    }

    /** Fluxo permitido de transições */
    public function transicoesPermitidas(): array
    {
        return match($this) {
            self::Aberta              => [self::EmAnalise, self::Cancelada],
            self::EmAnalise           => [self::AguardandoOrcamento, self::EmCorretiva, self::Cancelada],
            self::AguardandoOrcamento => [self::AguardandoPeca, self::EmCorretiva, self::Cancelada],
            self::AguardandoPeca      => [self::EmCorretiva],
            self::EmCorretiva         => [self::Finalizada],
            self::Finalizada          => [],
            self::Cancelada           => [],
        };
    }
}