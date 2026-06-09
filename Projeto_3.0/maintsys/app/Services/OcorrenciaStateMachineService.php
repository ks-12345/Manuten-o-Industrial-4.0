<?php

namespace App\Services;

use App\Enums\StatusOcorrencia;

use App\Models\Inspecao;
use App\Models\Ocorrencia;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

/**
 * Service central para o state machine de Ocorrências.
 * Regra: NENHUMA mudança de status fora de um service.
 */
class OcorrenciaStateMachineService
{
    /**
     * Interpreta o resultado da inspeção e aplica a transição correta.
     * A inspeção não define status diretamente.
     */
    public function finalizarAposInspecao(Ocorrencia $ocorrencia, Inspecao $inspecao, User $tecnico): Ocorrencia
    {
        return DB::transaction(function () use ($ocorrencia, $inspecao, $tecnico) {
            $ocorrencia->refresh();



            if ($inspecao->ocorrencia_id !== $ocorrencia->id) {
                throw ValidationException::withMessages([
                    'inspecao' => 'Inspeção não pertence à ocorrência informada.',
                ]);
            }

            if (!$inspecao->estaFinalizada()) {
                throw ValidationException::withMessages([
                    'inspecao' => 'Inspeção precisa estar finalizada para determinar o próximo status da ocorrência.',
                ]);
            }

            $novoStatus = $inspecao->necessita_peca
                ? StatusOcorrencia::AguardandoOrcamento
                : StatusOcorrencia::Corretiva;

            // Aplicar transição via OcorrenciaService (validando state machine).
            // Observação: OcorrenciaService::transicionarStatus já registra histórico.
            $ocorrenciaService = app(OcorrenciaService::class);

            if ($ocorrencia->status === $novoStatus) {
                return $ocorrencia;
            }

            if ($ocorrencia->status === StatusOcorrencia::Assumida) {
                $ocorrencia = $ocorrenciaService->transicionarStatus(
                    $ocorrencia,
                    StatusOcorrencia::EmInspecao,
                    $tecnico
                );
            }

            return $ocorrenciaService->transicionarStatus(
                $ocorrencia,
                $novoStatus,
                $tecnico
            );
        });
    }
}

