<?php

namespace App\Observers;

use App\Models\Historico;
use App\Models\Inspecao;

class InspecaoObserver
{
    public function created(Inspecao $inspecao): void
    {
        Historico::registrar(
            $inspecao->ocorrencia,
            Historico::ACAO_INSPECAO_INICIADA,
            "Inspeção iniciada pelo técnico {$inspecao->tecnico->name}"
        );
    }

    public function updated(Inspecao $inspecao): void
    {
        if ($inspecao->wasChanged('fim') && $inspecao->fim) {
            Historico::registrar(
                $inspecao->ocorrencia,
                Historico::ACAO_INSPECAO_FINALIZADA,
                "Inspeção finalizada. Necessita peça: " . ($inspecao->necessita_peca ? 'Sim' : 'Não')
            );
        }
    }
}