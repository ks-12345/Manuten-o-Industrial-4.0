<?php
namespace App\Services;

use App\Models\Maquina;
use App\Models\Preventiva;

class PreventivaService
{
    public function gerarProximaPreventiva(Maquina $maquina): ?Preventiva
    {
        if (!$maquina->periodicidade_preventiva) return null;

        $jaExiste = Preventiva::where('maquina_id', $maquina->id)
            ->where('status', 'pendente')
            ->exists();

        if ($jaExiste) return null;

        return Preventiva::create([
            'maquina_id'    => $maquina->id,
            'data_prevista' => $maquina->proxima_preventiva ?? now()->toDateString(),
            'status'        => 'pendente',
            'periodicidade' => $maquina->periodicidade_preventiva->value,
        ]);
    }

    public function finalizar(Preventiva $preventiva, array $dados): void
    {
        $preventiva->update([
            'status'                  => 'realizada',
            'data_realizada'          => now()->toDateString(),
            'tecnico_id'              => auth()->id(),
            'resumo'                  => $dados['resumo'] ?? null,
            'observacoes'             => $dados['observacoes'] ?? null,
            'tempo_realizado_minutos' => $dados['tempo'] ?? null,
        ]);

        $preventiva->maquina->update([
            'ultima_preventiva' => now()->toDateString(),
        ]);

        $preventiva->maquina->calcularProximaPreventiva();
        $this->gerarProximaPreventiva($preventiva->maquina);
    }

    public function gerarPreventivasPendentes(): int
    {
        $count = 0;

        Maquina::where('ativo', true)
            ->whereNotNull('periodicidade_preventiva')
            ->where(function ($q) {
                $q->whereNull('proxima_preventiva')
                  ->orWhere('proxima_preventiva', '<=', now()->addDays(3)->toDateString());
            })
            ->each(function (Maquina $maquina) use (&$count) {
                if ($this->gerarProximaPreventiva($maquina)) {
                    $count++;
                }
            });

        return $count;
    }
}