<?php
namespace App\Services;

use App\Enums\StatusInspecao;
use App\Enums\StatusOcorrencia;
use App\Models\Inspecao;
use App\Models\Ocorrencia;

class InspecaoService
{
    public function iniciar(Ocorrencia $ocorrencia): Inspecao
    {
        $inspecao = Inspecao::create([
            'ocorrencia_id' => $ocorrencia->id,
            'maquina_id'    => $ocorrencia->maquina_id,
            'tecnico_id'    => auth()->id(),
            'status'        => StatusInspecao::EmAndamento,
            'iniciado_em'   => now(),
        ]);

        $ocorrencia->update(['status' => StatusOcorrencia::EmAnalise]);

        return $inspecao;
    }

    public function finalizar(Inspecao $inspecao, array $dados): void
    {
        $inspecao->update([
            'diagnostico'              => $dados['diagnostico'] ?? null,
            'observacoes'              => $dados['observacoes'] ?? null,
            'outro_problema'           => $dados['outro_problema'] ?? false,
            'descricao_outro_problema' => $dados['descricao_outro_problema'] ?? null,
            'status'                   => StatusInspecao::Finalizada,
            'finalizado_em'            => now(),
        ]);
    }
}