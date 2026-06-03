<?php

namespace App\Policies;

use App\Models\Preventiva;
use App\Models\User;

class PreventivaPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('preventivas.view');
    }

    public function view(User $user, Preventiva $preventiva): bool
    {
        return $user->hasPermissionTo('preventivas.view')
            || $preventiva->tecnico_id === $user->id;
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('preventivas.create');
    }

    public function executar(User $user, Preventiva $preventiva): bool
    {
        return $user->hasPermissionTo('preventivas.executar')
            && $preventiva->status !== 'realizada';
    }
}