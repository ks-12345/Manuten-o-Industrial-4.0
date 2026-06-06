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
use App\Models\Ocorrencia;
use App\Models\Inspecao;
use App\Models\Preventiva;
use App\Observers\OcorrenciaObserver;
use App\Observers\InspecaoObserver;
use App\Observers\PreventivaObserver;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;


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
        
        Ocorrencia::observe(OcorrenciaObserver::class);
        Inspecao::observe(InspecaoObserver::class);
        Preventiva::observe(PreventivaObserver::class);

        DB::listen(function ($query) {
        if ($query->time > 100) {
            Log::info("SQL {$query->time}ms: {$query->sql}");
        }
    });
    
    }
}