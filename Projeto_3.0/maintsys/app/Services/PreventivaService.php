<?php

namespace App\Services;

use App\DTOs\PreventivaDTO;
use App\Enums\PeriodicidadePreventiva;
use App\Enums\StatusMaquina;
use App\Models\Historico;
use App\Models\Maquina;
use App\Models\Preventiva;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class PreventivaService
{
    public function __construct(
        private readonly HistoricoService $historicoService
    ) {}

    /**
     * Gerar preventivas futuras para todas as máquinas com periodicidade configurada.
     * Chamado via Artisan command agendado.
     */
    public function gerarPreventivasFuturas(int $mesesAfrente = 3): array
    {
        $maquinas = Maquina::whereNotNull('periodicidade_preventiva')
                           ->whereNull('deleted_at')
                           ->get();

        $geradas = 0;
        $erros   = 0;

        foreach ($maquinas as $maquina) {
            try {
                $geradas += $this->gerarParaMaquina($maquina, $mesesAfrente);
            } catch (\Exception $e) {
                $erros++;
                \Log::error("Erro ao gerar preventivas para máquina {$maquina->id}: " . $e->getMessage());
            }
        }

        return ['geradas' => $geradas, 'erros' => $erros];
    }

    /**
     * Gerar preventivas para uma máquina específica.
     */
    public function gerarParaMaquina(Maquina $maquina, int $mesesAfrente = 3): int
    {
        if (!$maquina->periodicidade_preventiva) {
            return 0;
        }

        $periodicidade = $maquina->periodicidade_preventiva;
        $intervalo     = $periodicidade->diasIntervalo();

        // Encontrar última preventiva (realizada ou pendente) no futuro
        $ultimaFutura = Preventiva::where('maquina_id', $maquina->id)
            ->where('status', '!=', 'cancelada')
            ->orderByDesc('data_prevista')
            ->first();

        // Data de início: última preventiva ou hoje
        $dataInicio = $ultimaFutura
            ? Carbon::parse($ultimaFutura->data_prevista)
            : ($maquina->ultima_preventiva ? Carbon::parse($maquina->ultima_preventiva) : now());

        $dataLimite = now()->addMonths($mesesAfrente);
        $geradas    = 0;

        $proxima = $dataInicio->copy()->addDays($intervalo);

        while ($proxima->lte($dataLimite)) {
            // Verificar se já existe preventiva nessa data (±3 dias)
            $existe = Preventiva::where('maquina_id', $maquina->id)
                ->whereBetween('data_prevista', [
                    $proxima->copy()->subDays(3)->toDateString(),
                    $proxima->copy()->addDays(3)->toDateString(),
                ])
                ->exists();

            if (!$existe) {
                Preventiva::create([
                    'maquina_id'    => $maquina->id,
                    'periodicidade' => $periodicidade->value,
                    'data_prevista' => $proxima->toDateString(),
                    'status'        => 'pendente',
                ]);
                $geradas++;
            }

            $proxima->addDays($intervalo);
        }

        return $geradas;
    }

    /**
     * Iniciar execução de uma preventiva.
     */
    public function iniciar(Preventiva $preventiva, User $tecnico): Preventiva
    {
        if ($preventiva->status === 'realizada') {
            throw ValidationException::withMessages([
                'preventiva' => 'Esta preventiva já foi realizada.',
            ]);
        }

        return DB::transaction(function () use ($preventiva, $tecnico) {
            $preventiva->update([
                'tecnico_id' => $tecnico->id,
                'status'     => 'em_andamento',
            ]);

            // Atualizar status da máquina
            $preventiva->maquina->update(['status' => StatusMaquina::Manutencao->value]);

            return $preventiva->fresh();
        });
    }

    /**
     * Finalizar preventiva.
     */
    public function finalizar(
        Preventiva $preventiva,
        User       $tecnico,
        ?string    $observacoes   = null,
        float      $custo         = 0,
        ?int       $tempoExecucao = null
    ): Preventiva {
        return DB::transaction(function () use ($preventiva, $tecnico, $observacoes, $custo, $tempoExecucao) {
            $preventiva->update([
                'status'         => 'realizada',
                'data_realizada' => now()->toDateString(),
                'observacoes'    => $observacoes,
                'custo'          => $custo,
                'tempo_execucao' => $tempoExecucao,
            ]);

            // Atualizar última preventiva da máquina
            $preventiva->maquina->update([
                'ultima_preventiva' => now()->toDateString(),
                'status'            => StatusMaquina::Operando->value,
            ]);

            $this->historicoService->registrar(
                $preventiva->maquina,
                Historico::ACAO_PREVENTIVA_REALIZADA,
                "Preventiva {$preventiva->periodicidade->getLabel()} realizada por {$tecnico->name}.",
                $tecnico
            );

            // Gerar próxima preventiva automaticamente
            $this->gerarParaMaquina($preventiva->maquina, 1);

            return $preventiva->fresh();
        });
    }

    /**
     * Marcar preventivas atrasadas.
     */
    public function marcarAtrasadas(): int
    {
        return Preventiva::where('status', 'pendente')
            ->where('data_prevista', '<', now()->toDateString())
            ->update(['status' => 'atrasada']);
    }

    /**
     * Estatísticas para dashboard.
     */
    public function estatisticas(): array
    {
        return [
            'pendentes'       => Preventiva::pendentes()->count(),
            'atrasadas'       => Preventiva::atrasadas()->count(),
            'realizadas_mes'  => Preventiva::where('status', 'realizada')
                ->whereMonth('data_realizada', now()->month)
                ->count(),
            'custo_mes'       => Preventiva::where('status', 'realizada')
                ->whereMonth('data_realizada', now()->month)
                ->sum('custo'),
        ];
    }
}