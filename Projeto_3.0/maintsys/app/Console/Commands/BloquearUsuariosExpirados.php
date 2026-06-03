<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;

class BloquearUsuariosExpirados extends Command
{
    protected $signature   = 'maintsys:bloquear-usuarios-expirados';
    protected $description = 'Desativa usuários temporários com data de expiração vencida';

    public function handle(): int
    {
        $count = User::where('is_temporary', true)
            ->where('ativo', true)
            ->where('data_expiracao', '<', now())
            ->update(['ativo' => false]);

        $this->info("✅ {$count} usuário(s) temporário(s) bloqueado(s).");

        return Command::SUCCESS;
    }
}