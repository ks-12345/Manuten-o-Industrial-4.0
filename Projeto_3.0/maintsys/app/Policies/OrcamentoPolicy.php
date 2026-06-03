<?php

namespace App\Policies;

use App\Models\Orcamento;
use App\Models\User;

class OrcamentoPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('orcamentos.view');
    }

    public function view(User $user, Orcamento $orcamento): bool
    {
        return $user->hasPermissionTo('orcamentos.view');
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('orcamentos.create');
    }

    public function aprovar(User $user, Orcamento $orcamento): bool
    {
        return $user->hasPermissionTo('orcamentos.aprovar')
            && !$orcamento->aprovado;
    }
}