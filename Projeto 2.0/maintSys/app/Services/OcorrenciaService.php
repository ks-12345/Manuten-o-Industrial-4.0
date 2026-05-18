<?php
namespace App\Services;

use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Models\Historico;
use App\Models\Ocorrencia;
use Illuminate\Support\Facades\Auth;

class OcorrenciaService
{
    public function assumir(Ocorrencia $ocorrencia): void
    {
        $ocorrencia->update([
            'tecnico_id'  => Auth::id(),
            'status'      => StatusOcorrencia::EmAnalise,
            'assumido_em' => now(),
        ]);

        $ocorrencia->maquina->update([
            'status' => StatusMaquina::Manutencao,
        ]);

        $this->log($ocorrencia, 'assumiu', 'Técnico assumiu a ocorrência');
    }

    public function finalizar(Ocorrencia $ocorrencia, array $dados = []): void
    {
        $ocorrencia->update([
            'status'              => StatusOcorrencia::Finalizado,
            'finalizado_em'       => now(),
            'observacoes_tecnico' => $dados['observacoes'] ?? null,
        ]);

        $ocorrencia->maquina->update([
            'status' => StatusMaquina::Operando,
        ]);

        $this->log($ocorrencia, 'finalizou', 'Ocorrência finalizada com sucesso');
    }

    public function cancelar(Ocorrencia $ocorrencia, string $motivo): void
    {
        $ocorrencia->update([
            'status'              => StatusOcorrencia::Cancelado,
            'finalizado_em'       => now(),
            'observacoes_tecnico' => $motivo,
        ]);

        $this->log($ocorrencia, 'cancelou', "Cancelada: {$motivo}");
    }

    private function log(Ocorrencia $ocorrencia, string $acao, string $descricao): void
    {
        Historico::create([
            'maquina_id'      => $ocorrencia->maquina_id,
            'user_id'         => Auth::id(),
            'historiavel_id'  => $ocorrencia->id,
            'historiavel_type' => Ocorrencia::class,
            'tipo'            => 'ocorrencia',
            'acao'            => $acao,
            'descricao'       => $descricao,
        ]);
    }
}