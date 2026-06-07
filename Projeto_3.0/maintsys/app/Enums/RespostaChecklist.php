<?php

namespace App\Enums;

use Filament\Support\Contracts\HasLabel;

enum RespostaChecklist: string implements HasLabel
{
    case Conforme = 'conforme';
    case NaoConforme = 'nao_conforme';
    case NaoAplicavel = 'nao_aplicavel';

    public function getLabel(): string
    {
        return match ($this) {
            self::Conforme => 'Conforme',
            self::NaoConforme => 'Não Conforme',
            self::NaoAplicavel => 'Não Aplicável',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $case) => [$case->value => $case->getLabel()])
            ->all();
    }
}
