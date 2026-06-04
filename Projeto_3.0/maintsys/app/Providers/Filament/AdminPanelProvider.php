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
            // ->login(Login::class)
            ->colors([
                'primary' => Color::Blue,
                'danger'  => Color::Rose,
                'warning' => Color::Amber,
                'success' => Color::Green,
                'info'    => Color::Sky,
            ])
            ->brandName('MaintSys 4.0')
            ->brandLogo(asset('images/logo.svg'))
            ->favicon(asset('images/favicon.ico'))
            ->darkMode(true)
            ->sidebarCollapsibleOnDesktop()
            ->navigationGroups([
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
            ->pages([
                MapaMaquinas::class,
            ])
            ->widgets([
                StatsAdminWidget::class,
                StatsProfessorWidget::class,
                StatsTecnicoWidget::class,
                OcorrenciasRecentesWidget::class,
                PreventivasPendentesWidget::class,
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