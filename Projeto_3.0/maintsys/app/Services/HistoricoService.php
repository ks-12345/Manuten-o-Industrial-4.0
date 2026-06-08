<?php

namespace App\Services;

use App\Models\Historico;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class HistoricoService
{
    /**
     * Registrar uma entrada no histórico.
     */
    public function registrar(
        Model   $model,
        string  $acao,
        string  $descricao,
        ?User   $user          = null,
        array   $dadosAnteriores = [],
        array   $dadosNovos      = []
    ): Historico {
        return Historico::create([
            'historiavel_type' => get_class($model),
            'historiavel_id'   => $model->getKey(),
            'user_id'          => $user?->id ?? Auth::id(),
            'acao'             => $acao,
            'descricao'        => $descricao,
            'dados_anteriores' => $dadosAnteriores ?: null,
            'dados_novos'      => $dadosNovos ?: null,
            'ip'               => request()->ip(),
            'created_at'       => now(),
        ]);
    }

    /**
     * Obter histórico completo de uma entidade.
     */
    public function obterHistorico(Model $model, int $limit = 50): \Illuminate\Database\Eloquent\Collection
    {
        return Historico::with('user:id,name')
            ->where('historiavel_type', get_class($model))
            ->where('historiavel_id', $model->getKey())
            ->orderByDesc('created_at')
            ->limit($limit)
            ->get();
    }

    /**
     * Histórico de ações de um usuário.
     */
    public function obterHistoricoUsuario(User $user, int $limit = 100): \Illuminate\Database\Eloquent\Collection
    {
        return Historico::where('user_id', $user->id)
            ->orderByDesc('created_at')
            ->limit($limit)
            ->get();
    }
}