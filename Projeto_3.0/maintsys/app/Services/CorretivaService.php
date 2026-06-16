<?php

namespace App\Services;

use App\DTOs\CorretivaDTO;
use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Enums\TipoCorretiva;
use App\Models\Corretiva;
use App\Models\Historico;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use App\Mail\AlertaManutencao;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;

class CorretivaService
{
    public function __construct(
        private readonly HistoricoService  $historicoService,
        private readonly OcorrenciaService $ocorrenciaService
    ) {}

    public function criar(CorretivaDTO $dto, User $tecnico): Corretiva
    {
        // Validação: corretiva originada de ocorrência exige inspeção finalizada.
        // Corretiva Direta (avulsa) não passa por essa regra.
        if ($dto->ocorrenciaId) {
            $inspecaoFinalizada = \App\Models\Inspecao::where('ocorrencia_id', $dto->ocorrenciaId)
                ->where('status', 'finalizada')
                ->exists();

            if (! $inspecaoFinalizada) {
                throw ValidationException::withMessages([
                    'ocorrencia_id' => 'Não é possível iniciar uma manutenção corretiva sem que a inspeção prévia desta ocorrência esteja finalizada.',
                ]);
            }
        }
        // FIX: Corretiva Direta (sem ocorrência) é permitida — bloco else removido.

        $corretiva = DB::transaction(function () use ($dto, $tecnico) {
            $corretiva = Corretiva::create(array_merge($dto->toArray(), [
                'status' => 'em_andamento',
                'inicio' => now(),
            ]));

            Maquina::find($dto->maquinaId)
                   ->update(['status' => StatusMaquina::Manutencao->value]);

            if ($dto->ocorrenciaId) {
                $ocorrencia = Ocorrencia::find($dto->ocorrenciaId);
                if ($ocorrencia) {
                    $ocorrencia->update([
                        'status' => StatusOcorrencia::Corretiva->value,
                    ]);
                }
            }

            $this->historicoService->registrar(
                $corretiva->maquina,
                Historico::ACAO_CORRETIVA_INICIADA,
                "Corretiva iniciada pelo técnico {$tecnico->name}. Tipo: {$corretiva->tipo->getLabel()}",
                $tecnico
            );

            return $corretiva;
        });

        try {
            $corretiva->load(['maquina', 'maquina.setor']);

            Mail::to('equipe.manutencao@empresa.com')->send(
                new AlertaManutencao(
                    codigoOrdemServico: (string) $corretiva->id,
                    maquina: $corretiva->maquina?->nome ?? 'Não identificada',
                    setor: $corretiva->maquina?->setor?->nome ?? 'Setor da Máquina',
                    tecnico: $tecnico->name ?? 'Técnico de Plantão',
                    urgencia: '🚨 CRÍTICO - Corretiva Solicitada',
                    descricaoProblema: $corretiva->descricao_falha ?? 'Manutenção Corretiva Aberta.'
                )
            );
        } catch (\Exception $e) {
            Log::error("Falha ao enviar e-mail de corretiva #{$corretiva->id}: " . $e->getMessage());
        }

        return $corretiva;
    }

    public function finalizar(
        Corretiva $corretiva,
        string    $solucao,
        string    $resumo,
        User      $tecnico,
        float     $custoPecas   = 0,
        float     $custoMaoObra = 0
    ): Corretiva {
        if ($corretiva->estaFinalizada()) {
            throw ValidationException::withMessages([
                'corretiva' => 'Esta corretiva já foi finalizada.',
            ]);
        }

        return DB::transaction(function () use ($corretiva, $solucao, $resumo, $tecnico, $custoPecas, $custoMaoObra) {
            $inicio = $corretiva->inicio ?? now()->subMinutes(30);
            $tempoReparo = (int) $inicio->diffInMinutes(now());

            $corretiva->update([
                'solucao'        => $solucao,
                'resumo'         => $resumo,
                'custo_pecas'    => $custoPecas,
                'custo_mao_obra' => $custoMaoObra,
                'tempo_reparo'   => $tempoReparo,
                'status'         => 'finalizada',
                'fim'            => now(),
            ]);

            $corretiva->maquina->update(['status' => StatusMaquina::Operando->value]);

            if ($corretiva->ocorrencia_id && $corretiva->ocorrencia) {
                $this->ocorrenciaService->transicionarStatus(
                    $corretiva->ocorrencia,
                    StatusOcorrencia::Concluida,
                    $tecnico
                );
            }

            $this->historicoService->registrar(
                $corretiva->maquina,
                Historico::ACAO_CORRETIVA_FINALIZADA,
                "Corretiva finalizada. Tempo: {$tempoReparo}min. Custo: R$ " . number_format($corretiva->custoTotal(), 2, ',', '.'),
                $tecnico
            );

            return $corretiva->fresh();
        });
    }

    public function estatisticas(): array
    {
        $mes = now()->startOfMonth();

        return [
            'em_andamento'    => Corretiva::emAndamento()->count(),
            'finalizadas_mes' => Corretiva::finalizadas()
                ->where('fim', '>=', $mes)
                ->count(),
            'custo_mes'       => Corretiva::finalizadas()
                ->where('fim', '>=', $mes)
                ->selectRaw('SUM(custo_pecas + custo_mao_obra) as total')
                ->value('total') ?? 0,
            'tempo_medio_min' => Corretiva::finalizadas()
                ->whereNotNull('tempo_reparo')
                ->avg('tempo_reparo') ?? 0,
        ];
    }
}