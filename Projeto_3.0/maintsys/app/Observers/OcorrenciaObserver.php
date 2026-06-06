<?php

namespace App\Observers;

use App\Models\Historico;
use App\Models\Ocorrencia;

class OcorrenciaObserver
{
    public function created(Ocorrencia $ocorrencia): void
    {
        Historico::registrar(
            $ocorrencia,
            Historico::ACAO_OCORRENCIA_CRIADA,
            "Ocorrência {$ocorrencia->codigo} criada por {$ocorrencia->professor->name}",
            dadosNovos: $ocorrencia->toArray()
        );
    }

public function updated(Ocorrencia $ocorrencia): void
{
    if ($ocorrencia->wasChanged('status')) {

        $statusAnterior = $ocorrencia->getOriginal('status');

        // garante string mesmo se vier enum em algum caso
        if ($statusAnterior instanceof \App\Enums\StatusOcorrencia) {
            $statusAnterior = $statusAnterior->value;
        }

        $statusNovo = $ocorrencia->status->value;

        Historico::registrar(
            $ocorrencia,
            Historico::ACAO_STATUS_ALTERADO,
            "Status alterado de '{$statusAnterior}' para '{$statusNovo}'",
            dadosAnteriores: ['status' => $statusAnterior],
            dadosNovos: ['status' => $statusNovo]
        );
    }

    if ($ocorrencia->wasChanged('tecnico_id') && $ocorrencia->tecnico_id) {

    $tecnico = $ocorrencia->tecnico; // pode ser null

    $nomeTecnico = $tecnico?->name
        ?? \App\Models\User::find($ocorrencia->tecnico_id)?->name
        ?? 'Desconhecido';

    Historico::registrar(
        $ocorrencia,
        Historico::ACAO_OCORRENCIA_ASSUMIDA,
        "Ocorrência assumida por {$nomeTecnico}"
    );
}
}
}