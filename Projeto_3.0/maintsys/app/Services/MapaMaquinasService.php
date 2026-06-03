<?php

namespace App\Services;

use App\Enums\StatusMaquina;
use App\Models\Maquina;
use App\Models\Setor;

class MapaMaquinasService
{
    /**
     * Retorna todas as máquinas com dados para renderização no mapa.
     */
    public function getMaquinasParaMapa(?int $setorId = null): array
    {
        $query = Maquina::with(['setor:id,nome,codigo', 'ocorrenciasAbertas'])
            ->select([
                'id', 'nome', 'patrimonio', 'status',
                'posicao_x', 'posicao_y', 'setor_id',
                'fabricante', 'modelo',
            ]);

        if ($setorId) {
            $query->where('setor_id', $setorId);
        }

        return $query->get()->map(fn(Maquina $m) => [
            'id'                 => $m->id,
            'nome'               => $m->nome,
            'patrimonio'         => $m->patrimonio,
            'status'             => $m->status->value,
            'status_label'       => $m->status->getLabel(),
            'cor'                => $m->status->hexColor(),
            'posicao_x'          => $m->posicao_x,
            'posicao_y'          => $m->posicao_y,
            'setor'              => $m->setor?->nome,
            'fabricante'         => $m->fabricante,
            'modelo'             => $m->modelo,
            'ocorrencias_abertas'=> $m->ocorrenciasAbertas->count(),
        ])->toArray();
    }

    /**
     * Atualizar posição de uma máquina no mapa (drag & drop).
     */
    public function atualizarPosicao(int $maquinaId, float $x, float $y): bool
    {
        return (bool) Maquina::where('id', $maquinaId)->update([
            'posicao_x' => max(0, $x),
            'posicao_y' => max(0, $y),
        ]);
    }

    /**
     * Resumo de status para a legenda do mapa.
     */
    public function resumoStatus(?int $setorId = null): array
    {
        $query = Maquina::query();
        if ($setorId) $query->where('setor_id', $setorId);

        $counts = $query->selectRaw('status, COUNT(*) as total')
            ->groupBy('status')
            ->pluck('total', 'status')
            ->toArray();

        return collect(StatusMaquina::cases())->map(fn($case) => [
            'status' => $case->value,
            'label'  => $case->getLabel(),
            'cor'    => $case->hexColor(),
            'total'  => $counts[$case->value] ?? 0,
        ])->toArray();
    }
}