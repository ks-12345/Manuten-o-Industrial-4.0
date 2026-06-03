<?php

namespace App\Policies;

use App\Models\Ocorrencia;
use App\Models\User;

class OcorrenciaPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo('ocorrencias.view')
            || $user->hasPermissionTo('ocorrencias.view_own');
    }

    public function view(User $user, Ocorrencia $ocorrencia): bool
    {
        if ($user->hasPermissionTo('ocorrencias.view')) return true;

        // Professor vê apenas as próprias
        if ($user->hasPermissionTo('ocorrencias.view_own')) {
            return $ocorrencia->professor_id === $user->id;
        }

        return false;
    }

    public function create(User $user): bool
    {
        return $user->hasPermissionTo('ocorrencias.create');
    }

    public function update(User $user, Ocorrencia $ocorrencia): bool
    {
        if ($ocorrencia->estaFinalizada() || $ocorrencia->estaCancelada()) {
            return false;
        }
        return $user->hasPermissionTo('ocorrencias.edit');
    }

    public function delete(User $user, Ocorrencia $ocorrencia): bool
    {
        return $user->hasPermissionTo('ocorrencias.delete');
    }

    public function assumir(User $user, Ocorrencia $ocorrencia): bool
    {
        return $user->hasPermissionTo('ocorrencias.assumir')
            && $ocorrencia->status->value === 'aberta'
            && $ocorrencia->tecnico_id === null;
    }

    public function cancelar(User $user, Ocorrencia $ocorrencia): bool
    {
        return $user->hasPermissionTo('ocorrencias.cancelar')
            && !$ocorrencia->estaFinalizada()
            && !$ocorrencia->estaCancelada();
    }
}