<?php

namespace App\Policies;

use App\Models\Corretiva;
use App\Models\User;

class CorretivaPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('corretivas.view');
    }

    public function view(User $user, Corretiva $corretiva): bool
    {
        return $user->hasPermissionTo('corretivas.view')
            || $corretiva->tecnico_id === $user->id;
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('corretivas.create');
    }

    public function update(User $user, Corretiva $corretiva): bool
    {
        if ($corretiva->estaFinalizada()) return false;

        return $user->hasPermissionTo('corretivas.executar')
            && $corretiva->tecnico_id === $user->id;
    }

    public function finalizar(User $user, Corretiva $corretiva): bool
    {
        return $user->hasPermissionTo('corretivas.executar')
            && $corretiva->tecnico_id === $user->id
            && !$corretiva->estaFinalizada();
    }
}