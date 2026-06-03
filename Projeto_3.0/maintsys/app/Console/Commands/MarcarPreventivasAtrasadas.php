<?php

namespace App\Console\Commands;

use App\Services\PreventivaService;
use Illuminate\Console\Command;

class MarcarPreventivasAtrasadas extends Command
{
    protected $signature   = 'maintsys:marcar-preventivas-atrasadas';
    protected $description = 'Marca como "atrasada" todas as preventivas pendentes com data passada';

    public function handle(PreventivaService $service): int
    {
        $count = $service->marcarAtrasadas();
        $this->info("✅ {$count} preventiva(s) marcada(s) como atrasada(s).");

        return Command::SUCCESS;
    }
}