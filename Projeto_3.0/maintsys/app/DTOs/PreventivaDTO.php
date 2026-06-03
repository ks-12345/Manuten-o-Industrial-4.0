<?php

namespace App\DTOs;

use App\Enums\PeriodicidadePreventiva;
use Carbon\Carbon;

readonly class PreventivaDTO
{
    public function __construct(
        public int                    $maquinaId,
        public PeriodicidadePreventiva $periodicidade,
        public Carbon                 $dataPrevista,
        public ?int                   $tecnicoId = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            maquinaId:     (int) $data['maquina_id'],
            periodicidade: PeriodicidadePreventiva::from($data['periodicidade']),
            dataPrevista:  Carbon::parse($data['data_prevista']),
            tecnicoId:     isset($data['tecnico_id']) ? (int) $data['tecnico_id'] : null,
        );
    }

    public function toArray(): array
    {
        return [
            'maquina_id'    => $this->maquinaId,
            'periodicidade' => $this->periodicidade->value,
            'data_prevista' => $this->dataPrevista->toDateString(),
            'tecnico_id'    => $this->tecnicoId,
            'status'        => 'pendente',
        ];
    }
}