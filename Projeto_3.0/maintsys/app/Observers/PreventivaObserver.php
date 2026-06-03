<?php

namespace App\Observers;

use App\Models\Historico;
use App\Models\Preventiva;

class PreventivaObserver
{
    public function updated(Preventiva $preventiva): void
    {
        if ($preventiva->wasChanged('status') && $preventiva->status === 'realizada') {
            Historico::registrar(
                $preventiva->maquina,
                Historico::ACAO_PREVENTIVA_REALIZADA,
                "Preventiva {$preventiva->periodicidade->getLabel()} realizada em {$preventiva->data_realizada->format('d/m/Y')}"
            );

            // Atualizar última preventiva da máquina
            $preventiva->maquina->update([
                'ultima_preventiva' => $preventiva->data_realizada,
            ]);
        }
    }
}