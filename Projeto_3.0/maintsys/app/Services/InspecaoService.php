<?php

namespace App\Services;

use App\DTOs\InspecaoDTO;
use App\Enums\StatusOcorrencia;
use App\Enums\StatusSolicitacaoPeca;
use App\Models\Historico;
use App\Models\Inspecao;
use App\Models\Ocorrencia;
use App\Models\SolicitacaoPeca;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Auth;

class InspecaoService
{
    public function __construct(
        private readonly HistoricoService  $historicoService,
        private readonly OcorrenciaService $ocorrenciaService
    ) {}

    /**
     * Iniciar inspeção de uma ocorrência.
     */
    public function iniciar(Ocorrencia $ocorrencia, User $tecnico): Inspecao
    {
        if ($ocorrencia->inspecao) {
            throw ValidationException::withMessages([
                'inspecao' => 'Já existe uma inspeção para esta ocorrência.',
            ]);
        }

        if ($ocorrencia->tecnico_id !== $tecnico->id) {
            throw ValidationException::withMessages([
                'tecnico' => 'Somente o técnico responsável pode iniciar a inspeção.',
            ]);
        }

        return DB::transaction(function () use ($ocorrencia, $tecnico) {
            $inspecao = Inspecao::create([
                'ocorrencia_id' => $ocorrencia->id,
                'tecnico_id'    => $tecnico->id,
                'inicio'        => now(),
            ]);

            $this->historicoService->registrar(
                $ocorrencia,
                Historico::ACAO_INSPECAO_INICIADA,
                "Inspeção iniciada pelo técnico {$tecnico->name}",
                $tecnico
            );

            return $inspecao;
        });
    }

    /**
     * Finalizar inspeção com diagnóstico.
     * Pergunta obrigatória: "Necessita substituição de peça?"
     */
    public function finalizar(
        Inspecao $inspecao,
        string   $diagnostico,
        bool     $necessitaPeca,
        User     $tecnico,
        ?string  $observacoes = null
    ): Inspecao {
        if ($inspecao->estaFinalizada()) {
            throw ValidationException::withMessages([
                'inspecao' => 'Esta inspeção já foi finalizada.',
            ]);
        }

        return DB::transaction(function () use ($inspecao, $diagnostico, $necessitaPeca, $tecnico, $observacoes) {
            $inspecao->update([
                'diagnostico'    => $diagnostico,
                'observacoes'    => $observacoes,
                'necessita_peca' => $necessitaPeca,
                'fim'            => now(),
            ]);

            $this->historicoService->registrar(
                $inspecao->ocorrencia,
                Historico::ACAO_INSPECAO_FINALIZADA,
                "Inspeção finalizada. Necessita peça: " . ($necessitaPeca ? 'Sim' : 'Não'),
                $tecnico
            );

            if ($necessitaPeca) {
                // Alterar status da ocorrência para aguardando orçamento
                $this->ocorrenciaService->transicionarStatus(
                    $inspecao->ocorrencia,
                    StatusOcorrencia::AguardandoOrcamento,
                    $tecnico,
                    'Peça necessária identificada na inspeção.'
                );
            } else {
                // Pode ir direto para corretiva
                $this->ocorrenciaService->transicionarStatus(
                    $inspecao->ocorrencia,
                    StatusOcorrencia::EmCorretiva,
                    $tecnico
                );
            }

            return $inspecao->fresh();
        });
    }

    /**
     * Solicitar peça após inspeção.
     */
    public function solicitarPeca(
        Inspecao $inspecao,
        array    $dados
    ): SolicitacaoPeca {
        if (!$inspecao->necessita_peca) {
            throw ValidationException::withMessages([
                'necessita_peca' => 'A inspeção não identificou necessidade de peça.',
            ]);
        }

        return DB::transaction(function () use ($inspecao, $dados) {
            $solicitacao = SolicitacaoPeca::create([
                'inspecao_id' => $inspecao->id,
                'maquina_id'  => $inspecao->ocorrencia->maquina_id,
                'nome_peca'   => $dados['nome_peca'],
                'quantidade'  => $dados['quantidade'] ?? 1,
                'descricao'   => $dados['descricao'] ?? null,
                'referencia'  => $dados['referencia'] ?? null,
                'status'      => StatusSolicitacaoPeca::Pendente->value,
            ]);

            $this->historicoService->registrar(
                $inspecao->ocorrencia,
                Historico::ACAO_SOLICITACAO_PECA,
                "Peça solicitada: {$solicitacao->nome_peca} (Qtd: {$solicitacao->quantidade})",
                Auth::user()
            );

            return $solicitacao;
        });
        
    }


    
}