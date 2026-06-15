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
        // Mantém assinatura antiga, mas aplica a regra:
        // Inspeção nasce da ocorrência e não pode duplicar.
        return $this->criarOuAbrirParaOcorrencia($ocorrencia, $tecnico);
    }

    /**
     * Cria ou abre a inspeção ativa vinculada à ocorrência.
     * Regra: uma ocorrência só pode ter uma inspeção ativa.
     */
    public function criarOuAbrirParaOcorrencia(Ocorrencia $ocorrencia, User $tecnico): Inspecao
    {
        if ($ocorrencia->tecnico_id !== $tecnico->id) {
            throw ValidationException::withMessages([
                'tecnico' => 'Somente o técnico responsável pode iniciar/executar a inspeção.',
            ]);
        }

        return DB::transaction(function () use ($ocorrencia, $tecnico) {
            $ocorrencia->refresh();

            // Se já existir inspeção (ativa), apenas abre.
            $inspecaoAtiva = $ocorrencia->inspecao()->whereNull('fim')->first();
            if ($inspecaoAtiva) {
                return $inspecaoAtiva;
            }

            // Regra: uma ocorrência só pode ter uma inspeção ativa.
            // Se existir inspeção ativa (fim NULL) já retornamos acima.
            // Portanto, podemos criar nova inspeção apenas se não houver inspeção ativa.

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

            // Inspeção não altera o status final da ocorrência.
            // A transição para EM_INSPECAO deve ser controlada pelo state machine oficial.
            // (Mantemos aqui apenas a criação/retorno da inspeção.)

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
            // Dentro da lógica de finalizar a Inspeção:
if ($inspecao->necessita_corretiva) {
    \App\Models\Corretiva::create([
        'maquina_id' => $inspecao->maquina_id,
        'ocorrencia_id' => $inspecao->ocorrencia_id,
        'status' => 'pendente', // <-- Ela nasce sem técnico e pendente
        'tecnico_id' => null,   // Sem dono por enquanto
        'descricao_falha' => 'Gerada automaticamente via Inspeção #' . $inspecao->id,
        'inicio' => null,       // Só começa quando alguém assumir
    ]);
}
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

            // Decisão de status NÃO é responsabilidade da Inspeção.
            // Ela apenas coleta dados técnicos e retorna o resultado.
            // A ocorrência será atualizada em OcorrenciaService::finalizarAposInspecao().


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