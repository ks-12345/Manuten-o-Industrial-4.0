<?php

namespace App\Services;

use App\DTOs\OcorrenciaDTO;
use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Models\Historico;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class OcorrenciaService
{
    public function __construct(
        private readonly HistoricoService $historicoService
    ) {}

    /**
     * Criar nova ocorrência.
     */
    public function criar(OcorrenciaDTO $dto): Ocorrencia
    {
        return DB::transaction(function () use ($dto) {
            $ocorrencia = Ocorrencia::create($dto->toArray());

            // Atualizar status da máquina para 'atencao' se estiver operando
            $maquina = Maquina::find($dto->maquinaId);
            if ($maquina && $maquina->status === StatusMaquina::Operando) {
                $maquina->update(['status' => StatusMaquina::Atencao->value]);
            }

            return $ocorrencia;
        });
    }

    /**
     * Técnico assume a ocorrência.
     */
    public function assumir(Ocorrencia $ocorrencia, User $tecnico): Ocorrencia
    {
        if (!$ocorrencia->status === StatusOcorrencia::Aberta) {
            throw ValidationException::withMessages([
                'status' => 'Apenas ocorrências abertas podem ser assumidas.',
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
                'status'      => StatusOcorrencia::EmAnalise->value,
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
     * Transicionar status da ocorrência.
     */
    public function transicionarStatus(
        Ocorrencia     $ocorrencia,
        StatusOcorrencia $novoStatus,
        User           $user,
        ?string        $observacao = null
    ): Ocorrencia {
        if (!$ocorrencia->podeTransicionarPara($novoStatus)) {
            throw ValidationException::withMessages([
                'status' => "Não é possível alterar de '{$ocorrencia->status->getLabel()}' para '{$novoStatus->getLabel()}'.",
            ]);
        }

        return DB::transaction(function () use ($ocorrencia, $novoStatus, $user, $observacao) {
            $statusAnterior = $ocorrencia->status;

            $updates = ['status' => $novoStatus->value];

            if ($novoStatus === StatusOcorrencia::Finalizada) {
                $updates['finalizada_em'] = now();
                // Restaurar status da máquina
                $ocorrencia->maquina->update(['status' => StatusMaquina::Operando->value]);
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
     * Cancelar ocorrência.
     */
    public function cancelar(Ocorrencia $ocorrencia, User $user, string $motivo): Ocorrencia
    {
        if ($ocorrencia->estaFinalizada() || $ocorrencia->estaCancelada()) {
            throw ValidationException::withMessages([
                'status' => 'Esta ocorrência não pode ser cancelada.',
            ]);
        }

        return DB::transaction(function () use ($ocorrencia, $user, $motivo) {
            $ocorrencia->update([
                'status'               => StatusOcorrencia::Cancelada->value,
                'observacoes_internas' => $motivo,
            ]);

            $this->historicoService->registrar(
                $ocorrencia,
                Historico::ACAO_OCORRENCIA_CANCELADA,
                "Ocorrência cancelada. Motivo: {$motivo}",
                $user
            );

            // Verificar se há outras ocorrências abertas para a máquina
            $outrasAbertas = Ocorrencia::where('maquina_id', $ocorrencia->maquina_id)
                ->whereNotIn('status', ['finalizada', 'cancelada'])
                ->where('id', '!=', $ocorrencia->id)
                ->exists();

            if (!$outrasAbertas) {
                $ocorrencia->maquina->update(['status' => StatusMaquina::Operando->value]);
            }

            return $ocorrencia->fresh();
        });
    }

    /**
     * Estatísticas para dashboard.
     */
    public function estatisticas(): array
    {
        return [
            'abertas'              => Ocorrencia::where('status', StatusOcorrencia::Aberta->value)->count(),
            'em_analise'           => Ocorrencia::where('status', StatusOcorrencia::EmAnalise->value)->count(),
            'aguardando_orcamento' => Ocorrencia::where('status', StatusOcorrencia::AguardandoOrcamento->value)->count(),
            'aguardando_peca'      => Ocorrencia::where('status', StatusOcorrencia::AguardandoPeca->value)->count(),
            'em_corretiva'         => Ocorrencia::where('status', StatusOcorrencia::EmCorretiva->value)->count(),
            'finalizadas_mes'      => Ocorrencia::where('status', StatusOcorrencia::Finalizada->value)
                ->whereMonth('finalizada_em', now()->month)
                ->count(),
        ];
    }

    /**
     * Ocorrências por professor (para dashboard do Professor).
     */
    public function ocorrenciasPorProfessor(User $professor): \Illuminate\Database\Eloquent\Collection
    {
        return Ocorrencia::with(['maquina.setor', 'tecnico'])
            ->where('professor_id', $professor->id)
            ->orderByDesc('created_at')
            ->get();
    }

    /**
     * Ocorrências atribuídas ao técnico (para dashboard do Técnico).
     */
    public function ocorrenciasPorTecnico(User $tecnico): \Illuminate\Database\Eloquent\Collection
    {
        return Ocorrencia::with(['maquina.setor', 'professor', 'inspecao'])
            ->where('tecnico_id', $tecnico->id)
            ->whereNotIn('status', ['finalizada', 'cancelada'])
            ->orderByDesc('created_at')
            ->get();
    }
}