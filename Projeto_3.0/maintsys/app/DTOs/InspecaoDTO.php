<?php

namespace App\DTOs;

readonly class InspecaoDTO
{
    public function __construct(
        public int     $ocorrenciaId,
        public int     $tecnicoId,
        public ?string $diagnostico  = null,
        public ?string $observacoes  = null,
        public ?bool   $necessitaPeca = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            ocorrenciaId:  (int) $data['ocorrencia_id'],
            tecnicoId:     (int) $data['tecnico_id'],
            diagnostico:   $data['diagnostico']   ?? null,
            observacoes:   $data['observacoes']   ?? null,
            necessitaPeca: isset($data['necessita_peca'])
                ? (bool) $data['necessita_peca']
                : null,
        );
    }

    public function toArray(): array
    {
        return array_filter([
            'ocorrencia_id' => $this->ocorrenciaId,
            'tecnico_id'    => $this->tecnicoId,
            'diagnostico'   => $this->diagnostico,
            'observacoes'   => $this->observacoes,
            'necessita_peca'=> $this->necessitaPeca,
        ], fn($v) => $v !== null);
    }
}