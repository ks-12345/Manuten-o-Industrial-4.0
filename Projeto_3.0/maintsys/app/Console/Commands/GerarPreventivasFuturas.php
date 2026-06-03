<?php

namespace App\Console\Commands;

use App\Services\PreventivaService;
use Illuminate\Console\Command;

class GerarPreventivasFuturas extends Command
{
    protected $signature   = 'maintsys:gerar-preventivas {--meses=3 : Quantos meses à frente gerar}';
    protected $description = 'Gera preventivas futuras para todas as máquinas cadastradas';

    public function handle(PreventivaService $service): int
    {
        $meses = (int) $this->option('meses');
        $this->info("Gerando preventivas para os próximos {$meses} meses...");

        $resultado = $service->gerarPreventivasFuturas($meses);

        $this->info("✅ Preventivas geradas: {$resultado['geradas']}");

        if ($resultado['erros'] > 0) {
            $this->warn("⚠️  Erros: {$resultado['erros']}");
        }

        return Command::SUCCESS;
    }
}