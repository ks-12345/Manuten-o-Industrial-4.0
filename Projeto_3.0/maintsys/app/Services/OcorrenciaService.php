<?php

namespace App\Services;

use App\DTOs\OcorrenciaDTO;
use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Models\Historico;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\User;
use App\Models\Inspecao;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class OcorrenciaService
{
    public function __construct(
        private readonly HistoricoService $historicoService
    ) {
    }

    /**
     * Criar nova ocorrência.
     */
    public function criar(OcorrenciaDTO $dto): Ocorrencia
    {
        return DB::transaction(function () use ($dto) {
            $ocorrencia = Ocorrencia::create($dto->toArray());

            $maquina = Maquina::find($dto->maquinaId);
            if ($maquina && $maquina->status === StatusMaquina::Operando) {
                $maquina->update(['status' => StatusMaquina::Atencao->value]);
            }

            return $ocorrencia;
        });
    }

    /**
     * Técnico assume a ocorrência: ABERTA -> ASSUMIDA.
     */
    public function assumir(Ocorrencia $ocorrencia, User $tecnico): Ocorrencia
    {
        $ocorrencia->refresh();

        if ($ocorrencia->status !== StatusOcorrencia::Aberta) {
            throw ValidationException::withMessages([
                'status' => 'Apenas ocorrências ABERTAS podem ser assumidas.',
            ]);
        }

        if ($ocorrencia->tecnico_id) {
            throw ValidationException::withMessages([
                'tecnico' => 'Esta ocorrência já foi assumida por outro técnico.',
            ]);
        }

        return DB::transaction(function () use ($ocorrencia, $tecnico) {
            $ocorrencia->update([
                'tecnico_id'  => $tecnico->id,
                'status'      => StatusOcorrencia::Assumida->value,
                'assumida_em' => now(),
            ]);

            $this->historicoService->registrar(
                $ocorrencia,
                Historico::ACAO_OCORRENCIA_ASSUMIDA,
                "Ocorrência assumida pelo técnico {$tecnico->name}",
                $tecnico
            );

            return $ocorrencia->fresh();
        });
    }

    /**
     * Transição genérica validada por state machine do enum.
     * Usar apenas para transições permitidas pelos estados oficiais.
     */
    public function transicionarStatus(
        Ocorrencia $ocorrencia,
        StatusOcorrencia $novoStatus,
        User $user,
        ?string $observacao = null
    ): Ocorrencia {
        $ocorrencia->refresh();

        if (!$ocorrencia->podeTransicionarPara($novoStatus)) {
            throw ValidationException::withMessages([
                'status' => "Não é possível alterar de '{$ocorrencia->status->getLabel()}' para '{$novoStatus->getLabel()}'.",
            ]);
        }

        return DB::transaction(function () use ($ocorrencia, $novoStatus, $user, $observacao) {
            $statusAnterior = $ocorrencia->status;

            $updates = ['status' => $novoStatus->value];

            if ($novoStatus === StatusOcorrencia::Concluida) {
                $updates['finalizada_em'] = now();

                // Restaurar status da máquina após conclusão.
                // Mantido simples: se houver máquina relacionada, retorna para Operando.
                if ($ocorrencia->relationLoaded('maquina') || $ocorrencia->maquina) {
                    $ocorrencia->maquina->update(['status' => StatusMaquina::Operando->value]);
                }
            }

            if ($observacao) {
                $updates['observacoes_internas'] = $observacao;
            }

            $ocorrencia->update($updates);

            $this->historicoService->registrar(
                $ocorrencia,
                Historico::ACAO_STATUS_ALTERADO,
                "Status alterado de '{$statusAnterior->getLabel()}' para '{$novoStatus->getLabel()}'",
                $user,
                ['status' => $statusAnterior->value],
                ['status' => $novoStatus->value]
            );

            return $ocorrencia->fresh();
        });
    }

    /**
     * State machine: decisão final após inspeção.
     * Obs: este método existe apenas para manter compatibilidade com o fluxo.
     */
    public function finalizarAposInspecao(Ocorrencia $ocorrencia, Inspecao $inspecao, User $tecnico): Ocorrencia
    {
        return app(OcorrenciaStateMachineService::class)
            ->finalizarAposInspecao($ocorrencia, $inspecao, $tecnico);
    }


    /**
     * Cancelamento NÃO faz parte do state machine.
     * Implementação propositalmente bloqueada para evitar estados fora do enum oficial.
     */
    public function cancelar(Ocorrencia $ocorrencia, User $user, string $motivo): Ocorrencia
    {
        throw ValidationException::withMessages([
            'status' => 'Cancelamento não faz parte do state machine oficial deste fluxo.',
        ]);
    }

    /**
     * Estatísticas para dashboard.
     */
    public function estatisticas(): array
    {
        return [
            'abertas'               => Ocorrencia::where('status', StatusOcorrencia::Aberta->value)->count(),
            'assumidas'             => Ocorrencia::where('status', StatusOcorrencia::Assumida->value)->count(),
            'em_inspecao'           => Ocorrencia::where('status', StatusOcorrencia::EmInspecao->value)->count(),
            'aguardando_orcamento' => Ocorrencia::where('status', StatusOcorrencia::AguardandoOrcamento->value)->count(),
            'corretiva'            => Ocorrencia::where('status', StatusOcorrencia::Corretiva->value)->count(),
            'concluidas_mes'       => Ocorrencia::where('status', StatusOcorrencia::Concluida->value)
                ->whereMonth('finalizada_em', now()->month)
                ->count(),
        ];
    }

    public function ocorrenciasPorProfessor(User $professor): \Illuminate\Database\Eloquent\Collection
    {
        return Ocorrencia::with(['maquina.setor', 'tecnico'])
            ->where('professor_id', $professor->id)
            ->orderByDesc('created_at')
            ->get();
    }

    public function ocorrenciasPorTecnico(User $tecnico): \Illuminate\Database\Eloquent\Collection
    {
        return Ocorrencia::with(['maquina.setor', 'professor', 'inspecao'])
            ->where('tecnico_id', $tecnico->id)
            ->orderByDesc('created_at')
            ->get();
    }
}

