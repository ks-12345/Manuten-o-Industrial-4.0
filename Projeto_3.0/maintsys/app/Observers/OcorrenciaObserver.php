<?php

namespace App\Observers;

use App\Models\Historico;
use App\Models\Ocorrencia;
use App\Mail\AlertaManutencao;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Models\User;

class OcorrenciaObserver
{
    public function created(Ocorrencia $ocorrencia): void
{
    // 1. Registra no histórico (Mantido original)
    Historico::registrar(
        $ocorrencia,
        Historico::ACAO_OCORRENCIA_CRIADA,
        "Ocorrência {$ocorrencia->codigo} criada por {$ocorrencia->professor->name}",
        dadosNovos: $ocorrencia->toArray()
    );

    // 2. Dispara o Alerta por E-mail ajustado
    try {
        // CORREÇÃO: Removemos o 'setor' daqui e carregamos 'maquina.setor' (o setor que pertence à máquina)
        $ocorrencia->load(['maquina', 'maquina.setor', 'professor']);

        Mail::to('equipe.manutencao@empresa.com')->send(
            new AlertaManutencao(
                codigoOrdemServico: (string) ($ocorrencia->codigo ?? $ocorrencia->id),
                maquina: $ocorrencia->maquina?->nome ?? 'Não identificada',
                // BUSCA CORRETA: Puxa o setor através do relacionamento da máquina
                setor: $ocorrencia->maquina?->setor?->nome ?? 'Não informado',
                tecnico: 'Triagem / Aguardando Atribuição',
                urgencia: "Ocorrência: " . (is_object($ocorrencia->prioridade) ? $ocorrencia->prioridade->value : ($ocorrencia->prioridade ?? 'Normal')),
                descricaoProblema: $ocorrencia->descricao ?? 'Sem descrição detalhada.'
            )
        );
    } catch (\Exception $e) {
        Log::error("Falha ao enviar e-mail de nova ocorrência #{$ocorrencia->id}: " . $e->getMessage());
    }
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
                ?? User::find($ocorrencia->tecnico_id)?->name // Usando o User importado de forma limpa
                ?? 'Desconhecido';

            Historico::registrar(
                $ocorrencia,
                Historico::ACAO_OCORRENCIA_ASSUMIDA,
                "Ocorrência assumida por {$nomeTecnico}"
            );
        }
    }
}