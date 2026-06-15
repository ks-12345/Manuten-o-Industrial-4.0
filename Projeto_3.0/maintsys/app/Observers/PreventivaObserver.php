<?php

namespace App\Observers;

use App\Models\Historico;
use App\Models\Preventiva;
use App\Mail\AlertaManutencao;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Models\User; 

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
    public function created(Preventiva $preventiva): void
    {
        try {
            $preventiva->load(['maquina', 'tecnico']);

            Mail::to('equipe.manutencao@empresa.com')->send(
                new AlertaManutencao(
                    codigoOrdemServico: (string) $preventiva->id,
                    maquina: $preventiva->maquina?->nome ?? 'Não identificada',
                    setor: $preventiva->maquina?->setor?->nome ?? 'Setor da Máquina',
                    tecnico: $preventiva->tecnico?->name ?? 'Não designado',
                    urgencia: 'Agenda Preventiva 🗓️',
                    descricaoProblema: "Manutenção preventiva agendada/gerada. Periodicidade: " . ($preventiva->periodicidade?->value ?? 'Padrão')
                )
            );
        } catch (\Exception $e) {
            Log::error("Falha ao enviar e-mail de preventiva #{$preventiva->id}: " . $e->getMessage());
        }
    }
}