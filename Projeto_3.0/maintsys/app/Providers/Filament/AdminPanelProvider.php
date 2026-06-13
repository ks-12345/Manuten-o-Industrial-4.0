<?php

namespace App\Providers\Filament;

use App\Filament\Pages\Auth\Login;
use App\Filament\Pages\MapaMaquinas;
use App\Filament\Resources\ChecklistModeloResource;
use App\Filament\Resources\CorretivaResource;
use App\Filament\Resources\InspecaoResource;
use App\Filament\Resources\MaquinaResource;
use App\Filament\Resources\OcorrenciaResource;
use App\Filament\Resources\OrcamentoResource;
use App\Filament\Resources\PreventivaResource;
use App\Filament\Resources\SetorResource;
use App\Filament\Resources\SolicitacaoPecaResource;
use App\Filament\Resources\UserResource;
use App\Filament\Widgets\OcorrenciasRecentesWidget;
use App\Filament\Widgets\PreventivasPendentesWidget;
use App\Filament\Widgets\StatsAdminWidget;
use App\Filament\Widgets\StatsProfessorWidget;
use App\Filament\Widgets\StatsTecnicoWidget;
use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Navigation\NavigationGroup;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\AuthenticateSession;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\View\Middleware\ShareErrorsFromSession;

class AdminPanelProvider extends PanelProvider
{
    public function panel(Panel $panel): Panel
    {
        return $panel
            ->default()
            ->id('admin')
            ->path('painel')
            ->login(\App\Filament\Pages\Auth\CustomLogin::class)
            // ->registration()
->colors([
    'primary' => '#A11D20', // Substitua pelo HEX exato desse vermelho
    'danger'  => '#E11D48',
    'warning' => '#FBBF24',
    'success' => '#34D399',
    'info'    => '#3B82F6',
])
->darkMode(false)

            // ->topNavigation()
            ->font('roboto')
            ->brandName('MaintSys 4.0')
            ->brandLogo(asset('images/logo-claro.png'))            // ->brandLogo(asset('images/logo-claro.png')) // Logo que vai aparecer no TEMA CLARO
            // ->darkModeBrandLogo(asset('images/logo-claro.png')) // Logo que vai aparecer no TEMA ESCURO
            ->brandLogoHeight('3rem') // Opcional: Ajuste a altura se a logo ficar muito pequena
            ->favicon(asset('images/favicon.png'))
            ->darkMode(true)
            ->sidebarCollapsibleOnDesktop()
            ->navigationGroups([
                NavigationGroup::make('Orc
                amentos')
                    ->icon('heroicon-o-cog-6-tooth'),
                NavigationGroup::make('Cadastros')
                    ->icon('heroicon-o-folder'),
                NavigationGroup::make('Operações')
                    ->icon('heroicon-o-wrench-screwdriver'),
                NavigationGroup::make('Manutenção')
                    ->icon('heroicon-o-cog'),
                NavigationGroup::make('Gestão')
                    ->icon('heroicon-o-chart-bar'),
                NavigationGroup::make('Configurações')
                    ->icon('heroicon-o-cog-6-tooth'),
            ])
            ->resources([
                UserResource::class,
                SetorResource::class,
                MaquinaResource::class,
                OcorrenciaResource::class,
                InspecaoResource::class,
                SolicitacaoPecaResource::class,
                OrcamentoResource::class,
                CorretivaResource::class,
                PreventivaResource::class,
                ChecklistModeloResource::class,
            ])
// Adicionar às pages:
->pages([
    MapaMaquinas::class,
    \App\Filament\Pages\MapaMaquinas::class,
    \App\Filament\Pages\Indicadores::class,
    \App\Filament\Pages\RelatorioManutencao::class,
    \App\Filament\Pages\Dashboard::class,
])


->widgets([
    StatsAdminWidget::class,
    StatsProfessorWidget::class,
    StatsTecnicoWidget::class,
    OcorrenciasRecentesWidget::class,
    PreventivasPendentesWidget::class,
    // \App\Filament\Widgets\Kpi\MtbfMttrWidget::class,
    \App\Filament\Widgets\Kpi\ResumoMesWidget::class,
    \App\Filament\Widgets\AlertasWidget::class,
    \App\Filament\Widgets\Charts\OcorrenciasPorStatusChart::class,
    \App\Filament\Widgets\Charts\OcorrenciasPorMesChart::class,
    \App\Filament\Widgets\Charts\FalhasPorMaquinaChart::class,
    \App\Filament\Widgets\Charts\FalhasPorSetorChart::class,
    \App\Filament\Widgets\Charts\CustosMensaisChart::class,
    \App\Filament\Widgets\Charts\CustosPorMaquinaChart::class,
    \App\Filament\Widgets\Charts\PreventivasRealizadasChart::class,
])
            ->middleware([
                EncryptCookies::class,
                AddQueuedCookiesToResponse::class,
                StartSession::class,
                AuthenticateSession::class,
                ShareErrorsFromSession::class,
                VerifyCsrfToken::class,
                SubstituteBindings::class,
                DisableBladeIconComponents::class,
                DispatchServingFilamentEvent::class,
                \App\Http\Middleware\VerificarUsuarioTemporario::class,
            ])
            ->authMiddleware([
                Authenticate::class,
            ]);
            
            
    }
    
}