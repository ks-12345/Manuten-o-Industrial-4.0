<?php

namespace App\Filament\Widgets;

use App\Enums\StatusMaquina;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use App\Models\SolicitacaoPeca;
use Filament\Widgets\Widget;
use Illuminate\Support\Facades\Auth;

class AlertasWidget extends Widget
{
    protected static string  $view            = 'filament.widgets.alertas';
    protected static ?string $heading         = 'Alertas Críticos';
    protected static ?int    $sort            = 0;
    protected int | string | array $columnSpan = 'full';

    public function getAlertas(): array
    {

    return Cache::remember(
        'dashboard_alertas',
        now()->addMinutes(5),
        function () {

        $alertas = [];

        // Máquinas quebradas
        $quebradas = Maquina::where('status', StatusMaquina::Quebrada->value)->count();
        if ($quebradas > 0) {
            $alertas[] = [
                'tipo'    => 'danger',
                'icon'    => 'heroicon-o-x-circle',
                'titulo'  => "{$quebradas} máquina(s) QUEBRADA(s)",
                'detalhe' => 'Necessita corretiva imediata.',
                'link'    => \App\Filament\Resources\MaquinaResource::getUrl('index') . '?tableFilters[status][value]=quebrada',
            ];
        }

        // Ocorrências críticas sem técnico
        $criticas = Ocorrencia::where('prioridade', 'critica')
            ->where('status', 'aberta')
            ->whereNull('tecnico_id')
            ->count();
        if ($criticas > 0) {
            $alertas[] = [
                'tipo'    => 'danger',
                'icon'    => 'heroicon-o-exclamation-triangle',
                'titulo'  => "{$criticas} ocorrência(s) CRÍTICA(s) sem técnico",
                'detalhe' => 'Atribuição imediata necessária.',
                'link'    => \App\Filament\Resources\OcorrenciaResource::getUrl('index'),
            ];
        }

        // Preventivas muito atrasadas (>7 dias)
        $atrasadas = Preventiva::where('status', 'pendente')
            ->where('data_prevista', '<', now()->subDays(7)->toDateString())
            ->count();
        if ($atrasadas > 0) {
            $alertas[] = [
                'tipo'    => 'warning',
                'icon'    => 'heroicon-o-calendar-days',
                'titulo'  => "{$atrasadas} preventiva(s) atrasada(s) há mais de 7 dias",
                'detalhe' => 'Agende a execução o quanto antes.',
                'link'    => \App\Filament\Resources\PreventivaResource::getUrl('index'),
            ];
        }

        // Peças aguardando aprovação de orçamento
        $semAprovacao = SolicitacaoPeca::where('status', 'pendente')
            ->where('created_at', '<', now()->subDays(3))
            ->count();
        if ($semAprovacao > 0) {
            $alertas[] = [
                'tipo'    => 'warning',
                'icon'    => 'heroicon-o-currency-dollar',
                'titulo'  => "{$semAprovacao} solicitação(ões) de peça sem orçamento há 3+ dias",
                'detalhe' => 'Cadastre os orçamentos para aprovação.',
                'link'    => \App\Filament\Resources\SolicitacaoPecaResource::getUrl('index'),
            ];
        }

        return $alertas;
    });
    }

    public static function canView(): bool
    {
        return Auth::user()?->hasRole('admin') || Auth::user()?->hasRole('tecnico');
    }
}