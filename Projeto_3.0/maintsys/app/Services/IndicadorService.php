<?php

namespace App\Services;

use App\Models\Corretiva;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use App\Models\Setor;
use Carbon\Carbon;

class IndicadorService
{
    /**
     * MTBF — Mean Time Between Failures (em horas).
     * MTBF = Tempo total disponível / Número de falhas
     */
    public function calcularMTBF(
        ?int    $maquinaId = null,
        ?Carbon $inicio    = null,
        ?Carbon $fim       = null
    ): float {
        $inicio ??= now()->startOfMonth();
        $fim    ??= now();

        $query = Ocorrencia::whereBetween('created_at', [$inicio, $fim])
            ->whereIn('status', ['finalizada']);

        if ($maquinaId) {
            $query->where('maquina_id', $maquinaId);
        }

        $totalFalhas = $query->count();

        if ($totalFalhas === 0) {
            return 0;
        }

        $horasDisponiveis = $inicio->diffInHours($fim);

        // Subtrair tempo total em corretiva (parada)
        $tempoParadaMinutos = Corretiva::whereBetween('inicio', [$inicio, $fim])
            ->when($maquinaId, fn($q) => $q->where('maquina_id', $maquinaId))
            ->whereNotNull('tempo_reparo')
            ->sum('tempo_reparo');

        $horasOperando = $horasDisponiveis - ($tempoParadaMinutos / 60);

        return $totalFalhas > 0 ? round($horasOperando / $totalFalhas, 2) : 0;
    }

    /**
     * MTTR — Mean Time To Repair (em horas).
     * MTTR = Tempo total de reparo / Número de reparos
     */
    public function calcularMTTR(
        ?int    $maquinaId = null,
        ?Carbon $inicio    = null,
        ?Carbon $fim       = null
    ): float {
        $inicio ??= now()->startOfMonth();
        $fim    ??= now();

        $query = Corretiva::where('status', 'finalizada')
            ->whereBetween('fim', [$inicio, $fim])
            ->whereNotNull('tempo_reparo');

        if ($maquinaId) {
            $query->where('maquina_id', $maquinaId);
        }

        $total   = $query->count();
        $somaMin = $query->sum('tempo_reparo');

        if ($total === 0) {
            return 0;
        }

        // Converter minutos → horas
        return round(($somaMin / $total) / 60, 2);
    }

    /**
     * Disponibilidade (%) de uma máquina.
     * Disponibilidade = MTBF / (MTBF + MTTR) * 100
     */
    public function calcularDisponibilidade(
        ?int    $maquinaId = null,
        ?Carbon $inicio    = null,
        ?Carbon $fim       = null
    ): float {
        $mtbf = $this->calcularMTBF($maquinaId, $inicio, $fim);
        $mttr = $this->calcularMTTR($maquinaId, $inicio, $fim);

 $denominador = $mtbf + $mttr;

if ($denominador <= 0) {
    return 100.0;
}

return round(($mtbf / $denominador) * 100, 2);
}

    /**
     * Quantidade de falhas por máquina no período.
     */
    public function falhasPorMaquina(?Carbon $inicio = null, ?Carbon $fim = null): array
    {
        $inicio ??= now()->startOfMonth();
        $fim    ??= now();

        return Ocorrencia::with('maquina:id,nome,patrimonio')
            ->whereBetween('created_at', [$inicio, $fim])
            ->selectRaw('maquina_id, COUNT(*) as total_falhas')
            ->groupBy('maquina_id')
            ->orderByDesc('total_falhas')
            ->get()
            ->map(fn($row) => [
                'maquina_id' => $row->maquina_id,
                'maquina'    => $row->maquina?->nome,
                'patrimonio' => $row->maquina?->patrimonio,
                'falhas'     => $row->total_falhas,
                'mtbf'       => $this->calcularMTBF($row->maquina_id, $inicio, $fim),
                'mttr'       => $this->calcularMTTR($row->maquina_id, $inicio, $fim),
                'disponib'   => $this->calcularDisponibilidade($row->maquina_id, $inicio, $fim),
            ])
            ->toArray();
    }

    /**
     * Quantidade de falhas por setor no período.
     */
    public function falhasPorSetor(?Carbon $inicio = null, ?Carbon $fim = null): array
    {
        $inicio ??= now()->startOfMonth();
        $fim    ??= now();

        return Ocorrencia::with('maquina.setor:id,nome,codigo')
            ->whereBetween('created_at', [$inicio, $fim])
            ->get()
            ->groupBy(fn($oc) => $oc->maquina?->setor_id)
            ->map(function ($ocorrencias, $setorId) {
                $setor = $ocorrencias->first()?->maquina?->setor;
                return [
                    'setor_id' => $setorId,
                    'setor'    => $setor?->nome,
                    'codigo'   => $setor?->codigo,
                    'falhas'   => $ocorrencias->count(),
                ];
            })
            ->sortByDesc('falhas')
            ->values()
            ->toArray();
    }

    /**
     * Custos de manutenção por máquina.
     */
    public function custosPorMaquina(?Carbon $inicio = null, ?Carbon $fim = null): array
    {
        $inicio ??= now()->startOfMonth();
        $fim    ??= now();

        $corretivas = Corretiva::with('maquina:id,nome,patrimonio')
            ->whereBetween('fim', [$inicio, $fim])
            ->where('status', 'finalizada')
            ->selectRaw('maquina_id, SUM(custo_pecas + custo_mao_obra) as custo_corretiva')
            ->groupBy('maquina_id')
            ->get()
            ->keyBy('maquina_id');

        $preventivas = Preventiva::with('maquina:id,nome,patrimonio')
            ->whereBetween('data_realizada', [$inicio->toDateString(), $fim->toDateString()])
            ->where('status', 'realizada')
            ->selectRaw('maquina_id, SUM(custo) as custo_preventiva')
            ->groupBy('maquina_id')
            ->get()
            ->keyBy('maquina_id');

        $maquinaIds = $corretivas->keys()->merge($preventivas->keys())->unique();

        return $maquinaIds->map(function ($maquinaId) use ($corretivas, $preventivas) {
            $c = $corretivas->get($maquinaId);
            $p = $preventivas->get($maquinaId);
            $maquina = $c?->maquina ?? $p?->maquina;

            $custoCorretiva  = (float) ($c?->custo_corretiva ?? 0);
            $custoPreventiva = (float) ($p?->custo_preventiva ?? 0);

            return [
                'maquina_id'       => $maquinaId,
                'maquina'          => $maquina?->nome,
                'patrimonio'       => $maquina?->patrimonio,
                'custo_corretiva'  => $custoCorretiva,
                'custo_preventiva' => $custoPreventiva,
                'custo_total'      => $custoCorretiva + $custoPreventiva,
            ];
        })
        ->sortByDesc('custo_total')
        ->values()
        ->toArray();
    }

    /**
     * Custos de manutenção por setor.
     */
    public function custosPorSetor(?Carbon $inicio = null, ?Carbon $fim = null): array
    {
        $custosPorMaquina = $this->custosPorMaquina($inicio, $fim);

        $maquinaIds = collect($custosPorMaquina)->pluck('maquina_id');
        $setoresPorMaquina = Maquina::whereIn('id', $maquinaIds)
            ->with('setor:id,nome,codigo')
            ->get()
            ->keyBy('id');

        return collect($custosPorMaquina)
            ->groupBy(fn($row) => $setoresPorMaquina[$row['maquina_id']]?->setor_id)
            ->map(function ($rows, $setorId) use ($setoresPorMaquina) {
                $maquinaId = $rows->first()['maquina_id'];
                $setor = $setoresPorMaquina[$maquinaId]?->setor;

                return [
                    'setor_id'         => $setorId,
                    'setor'            => $setor?->nome,
                    'codigo'           => $setor?->codigo,
                    'custo_corretiva'  => $rows->sum('custo_corretiva'),
                    'custo_preventiva' => $rows->sum('custo_preventiva'),
                    'custo_total'      => $rows->sum('custo_total'),
                    'maquinas'         => $rows->count(),
                ];
            })
            ->sortByDesc('custo_total')
            ->values()
            ->toArray();
    }

    /**
     * Resumo geral para o dashboard de indicadores.
     */
    public function resumoGeral(?Carbon $inicio = null, ?Carbon $fim = null): array
    {
        $inicio ??= now()->startOfMonth();
        $fim    ??= now();

        return [
            'periodo'              => [
                'inicio' => $inicio->format('d/m/Y'),
                'fim'    => $fim->format('d/m/Y'),
            ],
            'mtbf_geral'           => $this->calcularMTBF(null, $inicio, $fim),
            'mttr_geral'           => $this->calcularMTTR(null, $inicio, $fim),
            'disponibilidade_geral'=> $this->calcularDisponibilidade(null, $inicio, $fim),
            'total_falhas'         => Ocorrencia::whereBetween('created_at', [$inicio, $fim])->count(),
            'total_corretivas'     => Corretiva::whereBetween('created_at', [$inicio, $fim])->count(),
            'total_preventivas'    => Preventiva::where('status', 'realizada')
                ->whereBetween('data_realizada', [$inicio->toDateString(), $fim->toDateString()])
                ->count(),
            'custo_total'          => Corretiva::whereBetween('fim', [$inicio, $fim])
                ->where('status', 'finalizada')
                ->selectRaw('SUM(custo_pecas + custo_mao_obra) as total')
                ->value('total') ?? 0,
        ];
    }
}