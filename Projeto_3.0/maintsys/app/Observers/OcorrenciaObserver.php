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
            dados_novos: $ocorrencia->toArray()
        );
    }

    public function updated(Ocorrencia $ocorrencia): void
    {
        if ($ocorrencia->wasChanged('status')) {
            $statusAnterior = $ocorrencia->getOriginal('status');
            $statusNovo     = $ocorrencia->status->value;

            Historico::registrar(
                $ocorrencia,
                Historico::ACAO_STATUS_ALTERADO,
                "Status alterado de '{$statusAnterior}' para '{$statusNovo}'",
                dados_anteriores: ['status' => $statusAnterior],
                dados_novos: ['status' => $statusNovo]
            );
        }

        if ($ocorrencia->wasChanged('tecnico_id') && $ocorrencia->tecnico_id) {
            Historico::registrar(
                $ocorrencia,
                Historico::ACAO_OCORRENCIA_ASSUMIDA,
                "Ocorrência assumida por {$ocorrencia->tecnico->name}"
            );
        }
    }
}