<?php

namespace App\DTOs;

use App\Enums\PrioridadeOcorrencia;

readonly class OcorrenciaDTO
{
    public function __construct(
        public int                  $maquinaId,
        public int                  $professorId,
        public string               $titulo,
        public string               $descricao,
        public PrioridadeOcorrencia $prioridade = PrioridadeOcorrencia::Media,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            maquinaId:  (int) $data['maquina_id'],
            professorId:(int) $data['professor_id'],
            titulo:     $data['titulo'],
            descricao:  $data['descricao'],
            prioridade: PrioridadeOcorrencia::from($data['prioridade'] ?? 'media'),
        );
    }

    public function toArray(): array
    {
        return [
            'maquina_id'   => $this->maquinaId,
            'professor_id' => $this->professorId,
            'titulo'       => $this->titulo,
            'descricao'    => $this->descricao,
            'prioridade'   => $this->prioridade->value,
        ];
    }
}