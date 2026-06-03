<?php

namespace App\Policies;

use App\Models\Maquina;
use App\Models\User;

class MaquinaPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('maquinas.view');
    }

    public function view(User $user, Maquina $maquina): bool
    {
        return $user->hasPermissionTo('maquinas.view');
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('maquinas.create');
    }

    public function update(User $user, Maquina $maquina): bool
    {
        return $user->hasPermissionTo('maquinas.edit');
    }

    public function delete(User $user, Maquina $maquina): bool
    {
        return $user->hasPermissionTo('maquinas.delete');
    }

    public function viewMap(User $user): bool
    {
        return $user->hasPermissionTo('maquinas.map');
    }
}