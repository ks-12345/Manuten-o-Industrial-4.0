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
        public ?bool $necessitaCorretiva = true,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            ocorrenciaId:  (int) $data['ocorrencia_id'],
            tecnicoId:     (int) $data['tecnico_id'],
            diagnostico:   $data['diagnostico']   ?? null,
            observacoes:   $data['observacoes']   ?? null,

            necessitaPeca: isset($data['necessita_peca'])
                ? (bool) $data['necessita_peca'] : null,

            necessitaCorretiva: isset($data['necessita_corretiva'])
                ? (bool) $data['necessita_corretiva'] : true,
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
            'necessita_corretiva' => $this->necessitaCorretiva,
        ], fn($v) => $v !== null);
    }
}