<?php

namespace App\Policies;

use App\Models\SolicitacaoPeca;
use App\Models\User;

class SolicitacaoPecaPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('solicitacoes_pecas.view');
    }

    public function view(User $user, SolicitacaoPeca $solicitacaoPeca): bool
    {
        return $user->hasPermissionTo('solicitacoes_pecas.view');
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('solicitacoes_pecas.create');
    }

    public function update(User $user, SolicitacaoPeca $solicitacaoPeca): bool
    {
        return $user->hasPermissionTo('solicitacoes_pecas.edit');
    }

    public function delete(User $user, SolicitacaoPeca $solicitacaoPeca): bool
    {
        return $user->hasPermissionTo('solicitacoes_pecas.delete');
    }

    public function restore(User $user, SolicitacaoPeca $solicitacaoPeca): bool
    {
        return false;
    }

    public function forceDelete(User $user, SolicitacaoPeca $solicitacaoPeca): bool
    {
        return false;
    }
}