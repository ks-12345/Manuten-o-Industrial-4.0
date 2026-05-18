<?php
namespace App\Services;

use App\Enums\StatusCorretiva;
use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Models\Corretiva;
use App\Models\Inspecao;

class CorretivaService
{
    public function criarAPartirDaInspecao(Inspecao $inspecao, array $dados): Corretiva
    {
        $corretiva = Corretiva::create([
            'ocorrencia_id'        => $inspecao->ocorrencia_id,
            'inspecao_id'          => $inspecao->id,
            'maquina_id'           => $inspecao->maquina_id,
            'tecnico_id'           => auth()->id(),
            'problema_identificado' => $dados['problema'] ?? $inspecao->diagnostico,
            'status'               => StatusCorretiva::EmAndamento,
            'iniciado_em'          => now(),
        ]);

        $inspecao->ocorrencia->update([
            'status' => StatusOcorrencia::EmManutencao,
        ]);

        return $corretiva;
    }

    public function finalizar(Corretiva $corretiva, array $dados): void
    {
        $corretiva->update([
            'solucao_aplicada'     => $dados['solucao_aplicada'] ?? null,
            'resumo_tecnico'       => $dados['resumo_tecnico'] ?? null,
            'observacoes'          => $dados['observacoes'] ?? null,
            'tempo_reparo_minutos' => $dados['tempo_reparo_minutos'] ?? null,
            'foto_depois'          => $dados['foto_depois'] ?? null,
            'status'               => StatusCorretiva::Finalizada,
            'finalizado_em'        => now(),
        ]);

        $corretiva->maquina->update([
            'status' => StatusMaquina::Operando,
        ]);

        app(OcorrenciaService::class)->finalizar($corretiva->ocorrencia);
    }
}