<?php

namespace App\Providers;

use App\Services\CorretivaService;
use App\Services\HistoricoService;
use App\Services\IndicadorService;
use App\Services\InspecaoService;
use App\Services\MapaMaquinasService;
use App\Services\OcorrenciaService;
use App\Services\PreventivaService;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->singleton(HistoricoService::class);
        $this->app->singleton(MapaMaquinasService::class);
        $this->app->singleton(IndicadorService::class);
        $this->app->singleton(PreventivaService::class);

        $this->app->singleton(OcorrenciaService::class, function ($app) {
            return new OcorrenciaService($app->make(HistoricoService::class));
        });

        $this->app->singleton(InspecaoService::class, function ($app) {
            return new InspecaoService(
                $app->make(HistoricoService::class),
                $app->make(OcorrenciaService::class)
            );
        });

        $this->app->singleton(CorretivaService::class, function ($app) {
            return new CorretivaService(
                $app->make(HistoricoService::class),
                $app->make(OcorrenciaService::class)
            );
        });
    }

    public function boot(): void
    {
        // Observers registrados aqui (ver Fase 1)
    }
}