<?php
namespace App\Services;

use App\Models\Corretiva;
use App\Models\Maquina;

class IndicadorService
{
    public function calcularMTBF(Maquina $maquina, int $dias = 30): float
    {
        $falhas = Corretiva::where('maquina_id', $maquina->id)
            ->where('status', 'finalizada')
            ->where('created_at', '>=', now()->subDays($dias))
            ->count();

        if ($falhas === 0) return 0;

        return round(($dias * 24) / $falhas, 2);
    }

    public function calcularMTTR(Maquina $maquina, int $dias = 30): float
    {
        $corretivas = Corretiva::where('maquina_id', $maquina->id)
            ->where('status', 'finalizada')
            ->where('created_at', '>=', now()->subDays($dias))
            ->whereNotNull('tempo_reparo_minutos')
            ->get();

        if ($corretivas->isEmpty()) return 0;

        return round(($corretivas->sum('tempo_reparo_minutos') / $corretivas->count()) / 60, 2);
    }

    public function calcularDisponibilidade(Maquina $maquina, int $dias = 30): float
    {
        $mtbf = $this->calcularMTBF($maquina, $dias);
        $mttr = $this->calcularMTTR($maquina, $dias);

        if (($mtbf + $mttr) === 0.0) return 100.0;

        return round(($mtbf / ($mtbf + $mttr)) * 100, 2);
    }

    public function indicadoresGerais(int $dias = 30): array
    {
        $maquinas = Maquina::where('ativo', true)->get();

        return [
            'mtbf'            => round($maquinas->avg(fn($m) => $this->calcularMTBF($m, $dias)), 2),
            'mttr'            => round($maquinas->avg(fn($m) => $this->calcularMTTR($m, $dias)), 2),
            'disponibilidade' => round($maquinas->avg(fn($m) => $this->calcularDisponibilidade($m, $dias)), 2),
        ];
    }
}