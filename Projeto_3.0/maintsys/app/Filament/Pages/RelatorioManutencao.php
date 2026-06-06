<?php

namespace App\Filament\Pages;

use App\Models\Corretiva;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\Preventiva;
use App\Models\Setor;
use Carbon\Carbon;
use Filament\Pages\Page;
use Livewire\Attributes\Computed;
use Illuminate\Support\Facades\Auth;

class RelatorioManutencao extends Page
{
    protected static ?string $navigationIcon  = 'heroicon-o-document-chart-bar';
    protected static ?string $navigationGroup = 'Gestão';
    protected static ?string $navigationLabel = 'Relatórios';
    protected static ?string $title           = 'Relatório de Manutenção';
    protected static ?int    $navigationSort  = 2;
    protected static string  $view            = 'filament.pages.relatorio-manutencao';

    public string  $dataInicio = '';
    public string  $dataFim    = '';
    public ?int    $setorId    = null;
    public ?int    $maquinaId  = null;
    public string  $tipo       = 'completo'; // completo | ocorrencias | corretivas | preventivas

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('indicadores.view') ?? false;
    }

    public function mount(): void
    {
        $this->dataInicio = now()->startOfMonth()->toDateString();
        $this->dataFim    = now()->toDateString();
    }

    #[Computed]
    public function relatorio(): array
    {
        $inicio = Carbon::parse($this->dataInicio)->startOfDay();
        $fim    = Carbon::parse($this->dataFim)->endOfDay();

        $ocorrencias = Ocorrencia::with(['maquina.setor', 'professor', 'tecnico', 'inspecao'])
            ->when($this->maquinaId, fn($q) => $q->where('maquina_id', $this->maquinaId))
            ->when($this->setorId, fn($q) => $q->whereHas('maquina', fn($q2) => $q2->where('setor_id', $this->setorId)))
            ->whereBetween('created_at', [$inicio, $fim])
            ->orderBy('created_at')
            ->get();

        $corretivas = Corretiva::with(['maquina.setor', 'tecnico', 'ocorrencia'])
            ->when($this->maquinaId, fn($q) => $q->where('maquina_id', $this->maquinaId))
            ->when($this->setorId, fn($q) => $q->whereHas('maquina', fn($q2) => $q2->where('setor_id', $this->setorId)))
            ->whereBetween('created_at', [$inicio, $fim])
            ->orderBy('created_at')
            ->get();

        $preventivas = Preventiva::with(['maquina.setor', 'tecnico'])
            ->when($this->maquinaId, fn($q) => $q->where('maquina_id', $this->maquinaId))
            ->when($this->setorId, fn($q) => $q->whereHas('maquina', fn($q2) => $q2->where('setor_id', $this->setorId)))
            ->whereBetween('data_prevista', [$inicio->toDateString(), $fim->toDateString()])
            ->orderBy('data_prevista')
            ->get();

        return [
            'ocorrencias' => $ocorrencias,
            'corretivas'  => $corretivas,
            'preventivas' => $preventivas,
            'totais' => [
                'ocorrencias'  => $ocorrencias->count(),
                'corretivas'   => $corretivas->count(),
                'preventivas'  => $preventivas->count(),
                'custo_total'  => $corretivas->sum(fn($c) => $c->custoTotal())
                                + $preventivas->sum('custo'),
                'tempo_total'  => $corretivas->sum('tempo_reparo'),
            ],
        ];
    }

    public function getSetores()
    {
        return Setor::ativos()->get(['id', 'nome']);
    }

    public function getMaquinas()
    {
        return Maquina::when($this->setorId, fn($q) => $q->where('setor_id', $this->setorId))
                      ->get(['id', 'nome']);
    }
}