<?php

namespace App\DTOs;

use App\Enums\TipoCorretiva;

readonly class CorretivaDTO
{
    public function __construct(
        public int          $maquinaId,
        public int          $tecnicoId,
        public TipoCorretiva $tipo,
        public string       $problema,
        public ?int         $ocorrenciaId   = null,
        public ?string      $solucao        = null,
        public ?string      $resumo         = null,
        public float        $custoPecas     = 0,
        public float        $custoMaoObra   = 0,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            maquinaId:    (int) $data['maquina_id'],
            tecnicoId:    (int) $data['tecnico_id'],
            tipo:         TipoCorretiva::from($data['tipo'] ?? 'direta'),
            problema:     $data['problema'],
            ocorrenciaId: isset($data['ocorrencia_id']) ? (int) $data['ocorrencia_id'] : null,
            solucao:      $data['solucao']      ?? null,
            resumo:       $data['resumo']       ?? null,
            custoPecas:   (float) ($data['custo_pecas']   ?? 0),
            custoMaoObra: (float) ($data['custo_mao_obra'] ?? 0),
        );
    }

    public function toArray(): array
    {
        return [
            'maquina_id'     => $this->maquinaId,
            'tecnico_id'     => $this->tecnicoId,
            'tipo'           => $this->tipo->value,
            'problema'       => $this->problema,
            'ocorrencia_id'  => $this->ocorrenciaId,
            'solucao'        => $this->solucao,
            'resumo'         => $this->resumo,
            'custo_pecas'    => $this->custoPecas,
            'custo_mao_obra' => $this->custoMaoObra,
        ];
    }
}