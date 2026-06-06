<?php

namespace App\Filament\Pages;

use App\Services\IndicadorService;
use Carbon\Carbon;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Select;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Pages\Page;
use Livewire\Attributes\Computed;
use Illuminate\Support\Facades\Auth;

class Indicadores extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon  = 'heroicon-o-chart-bar-square';
    protected static ?string $navigationGroup = 'Gestão';
    protected static ?string $navigationLabel = 'Indicadores';
    protected static ?string $title           = 'Indicadores de Manutenção';
    protected static ?int    $navigationSort  = 1;
    protected static string  $view            = 'filament.pages.indicadores';

    // Filtros
    public ?string $periodoPreset = 'mes';
    public ?string $dataInicio    = null;
    public ?string $dataFim       = null;
    public ?int    $maquinaId     = null;
    public ?int    $setorId       = null;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('indicadores.view') ?? false;
    }

    public function mount(): void
    {
        $this->dataInicio = now()->startOfMonth()->toDateString();
        $this->dataFim    = now()->toDateString();
    }

    public function aplicarFiltro(): void
    {
        if ($this->periodoPreset !== 'custom') {
            [$this->dataInicio, $this->dataFim] = match($this->periodoPreset) {
                'semana'    => [now()->startOfWeek()->toDateString(), now()->toDateString()],
                'mes'       => [now()->startOfMonth()->toDateString(), now()->toDateString()],
                'trimestre' => [now()->startOfQuarter()->toDateString(), now()->toDateString()],
                'semestre'  => [now()->subMonths(6)->startOfMonth()->toDateString(), now()->toDateString()],
                'ano'       => [now()->startOfYear()->toDateString(), now()->toDateString()],
                default     => [now()->startOfMonth()->toDateString(), now()->toDateString()],
            };
        }
    }

    #[Computed]
    public function dados(): array
    {
        $service = app(IndicadorService::class);
        $inicio  = Carbon::parse($this->dataInicio);
        $fim     = Carbon::parse($this->dataFim)->endOfDay();

        return [
            'resumo'         => $service->resumoGeral($inicio, $fim),
            'mtbf'           => $service->calcularMTBF($this->maquinaId, $inicio, $fim),
            'mttr'           => $service->calcularMTTR($this->maquinaId, $inicio, $fim),
            'disponibilidade'=> $service->calcularDisponibilidade($this->maquinaId, $inicio, $fim),
            'por_maquina'    => $service->falhasPorMaquina($inicio, $fim),
            'por_setor'      => $service->falhasPorSetor($inicio, $fim),
            'custos_maquina' => $service->custosPorMaquina($inicio, $fim),
            'custos_setor'   => $service->custosPorSetor($inicio, $fim),
        ];
    }

    public function exportarCSV(): \Symfony\Component\HttpFoundation\StreamedResponse
    {
        $dados  = $this->dados;
        $inicio = $this->dataInicio;
        $fim    = $this->dataFim;

        return response()->streamDownload(function () use ($dados, $inicio, $fim) {
            $file = fopen('php://output', 'w');

            // BOM para UTF-8 no Excel
            fputs($file, "\xEF\xBB\xBF");

            // Cabeçalho geral
            fputcsv($file, ['MaintSys 4.0 — Relatório de Indicadores'], ';');
            fputcsv($file, ["Período: {$inicio} a {$fim}"], ';');
            fputcsv($file, [], ';');

            // KPIs
            fputcsv($file, ['Indicador', 'Valor'], ';');
            fputcsv($file, ['MTBF (h)',           number_format($dados['mtbf'], 2, ',', '.')], ';');
            fputcsv($file, ['MTTR (h)',            number_format($dados['mttr'], 2, ',', '.')], ';');
            fputcsv($file, ['Disponibilidade (%)', number_format($dados['disponibilidade'], 2, ',', '.')], ';');
            fputcsv($file, ['Total de Falhas',     $dados['resumo']['total_falhas']], ';');
            fputcsv($file, ['Corretivas',          $dados['resumo']['total_corretivas']], ';');
            fputcsv($file, ['Preventivas',         $dados['resumo']['total_preventivas']], ';');
            fputcsv($file, ['Custo Total (R$)',    number_format($dados['resumo']['custo_total'], 2, ',', '.')], ';');
            fputcsv($file, [], ';');

            // Falhas por máquina
            fputcsv($file, ['Máquina', 'Patrimônio', 'Falhas', 'MTBF (h)', 'MTTR (h)', 'Disponibilidade (%)'], ';');
            foreach ($dados['por_maquina'] as $row) {
                fputcsv($file, [
                    $row['maquina'],
                    $row['patrimonio'] ?? '—',
                    $row['falhas'],
                    number_format($row['mtbf'], 2, ',', '.'),
                    number_format($row['mttr'], 2, ',', '.'),
                    number_format($row['disponib'], 2, ',', '.'),
                ], ';');
            }
            fputcsv($file, [], ';');

            // Custos por setor
            fputcsv($file, ['Setor', 'Máquinas', 'Custo Corretivas (R$)', 'Custo Preventivas (R$)', 'Total (R$)'], ';');
            foreach ($dados['custos_setor'] as $row) {
                fputcsv($file, [
                    $row['setor'],
                    $row['maquinas'],
                    number_format($row['custo_corretiva'],  2, ',', '.'),
                    number_format($row['custo_preventiva'], 2, ',', '.'),
                    number_format($row['custo_total'],      2, ',', '.'),
                ], ';');
            }

            fclose($file);
        }, "indicadores_{$inicio}_{$fim}.csv", [
            'Content-Type' => 'text/csv; charset=UTF-8',
        ]);
    }
}