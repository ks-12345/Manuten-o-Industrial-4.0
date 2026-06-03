<?php

namespace App\Providers;

use App\Models\Inspecao;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use App\Observers\InspecaoObserver;
use App\Observers\OcorrenciaObserver;
use App\Observers\PreventivaObserver;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        Ocorrencia::observe(OcorrenciaObserver::class);
        Inspecao::observe(InspecaoObserver::class);
        Preventiva::observe(PreventivaObserver::class);
    }
}