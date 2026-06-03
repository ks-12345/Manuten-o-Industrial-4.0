<?php

namespace App\Providers;

use App\Models\Corretiva;
use App\Models\Inspecao;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\Orcamento;
use App\Models\Preventiva;
use App\Models\SolicitacaoPeca;
use App\Policies\CorretivaPolicy;
use App\Policies\InspecaoPolicy;
use App\Policies\MaquinaPolicy;
use App\Policies\OcorrenciaPolicy;
use App\Policies\OrcamentoPolicy;
use App\Policies\PreventivaPolicy;
use App\Policies\SolicitacaoPecaPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        Maquina::class        => MaquinaPolicy::class,
        Ocorrencia::class     => OcorrenciaPolicy::class,
        Inspecao::class       => InspecaoPolicy::class,
        SolicitacaoPeca::class=> SolicitacaoPecaPolicy::class,
        Orcamento::class      => OrcamentoPolicy::class,
        Corretiva::class      => CorretivaPolicy::class,
        Preventiva::class     => PreventivaPolicy::class,
    ];

    public function boot(): void
    {
        $this->registerPolicies();
    }
}