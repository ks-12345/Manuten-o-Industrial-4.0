<?php

namespace App\Observers;

use App\Enums\StatusOcorrencia;
use App\Enums\TipoCorretiva;
use App\Models\Corretiva;
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
        Historico::registrar(
            $ocorrencia,
            Historico::ACAO_OCORRENCIA_CRIADA,
            "Ocorrência {$ocorrencia->codigo} criada por {$ocorrencia->professor->name}",
            dadosNovos: $ocorrencia->toArray()
        );

        try {
            $ocorrencia->load(['maquina', 'maquina.setor', 'professor']);

            Mail::to('equipe.manutencao@empresa.com')->send(
                new AlertaManutencao(
                    codigoOrdemServico: (string) ($ocorrencia->codigo ?? $ocorrencia->id),
                    maquina: $ocorrencia->maquina?->nome ?? 'Não identificada',
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

            if ($statusAnterior instanceof StatusOcorrencia) {
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

            // ─────────────────────────────────────────────────────────────────
            // FIX PRINCIPAL: Quando a ocorrência entra em status "Corretiva",
            // criamos automaticamente uma Corretiva PENDENTE (sem técnico),
            // para que ela apareça na aba "Pendentes" e um técnico possa assumir.
            // ─────────────────────────────────────────────────────────────────
            if ($ocorrencia->status === StatusOcorrencia::Corretiva) {
                $jaExiste = Corretiva::where('ocorrencia_id', $ocorrencia->id)
                    ->whereIn('status', ['pendente', 'em_andamento'])
                    ->exists();

                if (! $jaExiste) {
                    Corretiva::create([
                        'maquina_id'   => $ocorrencia->maquina_id,
                        'ocorrencia_id'=> $ocorrencia->id,
                        'tipo'         => TipoCorretiva::OrigemOcorrencia->value,
                        'problema'     => $ocorrencia->descricao
                                          ?? 'Manutenção corretiva originada de inspeção/ocorrência.',
                        'status'       => 'pendente',
                        'tecnico_id'   => null, // sem dono → aparece na aba Pendentes
                    ]);
                }
            }
        }

        if ($ocorrencia->wasChanged('tecnico_id') && $ocorrencia->tecnico_id) {
            $nomeTecnico = $ocorrencia->tecnico?->name
                ?? User::find($ocorrencia->tecnico_id)?->name
                ?? 'Desconhecido';

            Historico::registrar(
                $ocorrencia,
                Historico::ACAO_OCORRENCIA_ASSUMIDA,
                "Ocorrência assumida por {$nomeTecnico}"
            );
        }
    }
}