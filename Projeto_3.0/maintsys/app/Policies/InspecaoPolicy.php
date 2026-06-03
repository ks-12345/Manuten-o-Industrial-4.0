<?php

namespace App\Policies;

use App\Models\Inspecao;
use App\Models\User;

class InspecaoPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('inspecoes.view');
    }

    public function view(User $user, Inspecao $inspecao): bool
    {
        return $user->hasPermissionTo('inspecoes.view')
            || $inspecao->tecnico_id === $user->id;
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('inspecoes.create');
    }

    public function update(User $user, Inspecao $inspecao): bool
    {
        if ($inspecao->estaFinalizada()) return false;

        return $user->hasPermissionTo('inspecoes.executar')
            && $inspecao->tecnico_id === $user->id;
    }

    public function finalizar(User $user, Inspecao $inspecao): bool
    {
        return $user->hasPermissionTo('inspecoes.executar')
            && $inspecao->tecnico_id === $user->id
            && $inspecao->podeFinalizar();
    }
}