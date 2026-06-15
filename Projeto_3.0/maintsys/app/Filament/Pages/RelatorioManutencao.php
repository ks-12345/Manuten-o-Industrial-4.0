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
use Filament\Actions\Action;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

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


protected function getHeaderActions(): array
{
    return [
        Action::make('exportar_excel')
            ->label('Exportar Excel Completo')
            ->icon('heroicon-o-table-cells')
            ->color('success')
            ->action(function () {
                $dados = $this->relatorio;
                $spreadsheet = new Spreadsheet();

                // --- ABA 1: RESUMO E TOTAIS ---
                $sheetResumo = $spreadsheet->getActiveSheet();
                $sheetResumo->setTitle('Resumo');
                
                $sheetResumo->setCellValue('A1', 'TOTAIS DO PERÍODO');
                $sheetResumo->setCellValue('A3', 'Total Ocorrências');
                $sheetResumo->setCellValue('B3', (int) $dados['totais']['ocorrencias']);
                $sheetResumo->setCellValue('A4', 'Total Corretivas');
                $sheetResumo->setCellValue('B4', (int) $dados['totais']['corretivas']);
                $sheetResumo->setCellValue('A5', 'Total Preventivas');
                $sheetResumo->setCellValue('B5', (int) $dados['totais']['preventivas']);
                $sheetResumo->setCellValue('A6', 'Custo Total (R$)');
                $sheetResumo->setCellValue('B6', (float) $dados['totais']['custo_total']); // Garante que é número

                $sheetResumo->getColumnDimension('A')->setWidth(25);
                $sheetResumo->getColumnDimension('B')->setWidth(15);


                // --- ABA 2: OCORRÊNCIAS ---
                if (isset($dados['ocorrencias']) && $dados['ocorrencias']->isNotEmpty()) {
                    $sheetOco = $spreadsheet->createSheet();
                    $sheetOco->setTitle('Ocorrências');
                    
                    $sheetOco->setCellValue('A1', 'Código');
                    $sheetOco->setCellValue('B1', 'Título / Descrição');
                    $sheetOco->setCellValue('C1', 'Máquina');
                    $sheetOco->setCellValue('D1', 'Setor');
                    $sheetOco->setCellValue('E1', 'Prioridade');
                    $sheetOco->setCellValue('F1', 'Status');
                    $sheetOco->setCellValue('G1', 'Professor');
                    $sheetOco->setCellValue('H1', 'Técnico');
                    $sheetOco->setCellValue('I1', 'Data');

                    $linha = 2;
                    foreach ($dados['ocorrencias'] as $oco) {
                        $nomeMaquina = $oco->maquina->nome ?? $oco->maquina->numeroSerie ?? $oco->maquina->codigo ?? 'N/A';
                        $nomeProfessor = $oco->professor->name ?? $oco->professor->nome ?? '-';
                        $nomeTecnico = $oco->tecnico->name ?? $oco->tecnico->nome ?? '-';

                        // TRATATIVA DO ERRO AQUI: Se for Enum, pega o ->value, senão usa o próprio valor como string
                        $prioridade = $oco->prioridade instanceof \BackedEnum ? $oco->prioridade->value : (string) ($oco->prioridade ?? '-');
                        $status = $oco->status instanceof \BackedEnum ? $oco->status->value : (string) ($oco->status ?? '-');

                        $sheetOco->setCellValue('A' . $linha, $oco->id);
                        $sheetOco->setCellValue('B' . $linha, (string) ($oco->titulo ?? $oco->descricao ?? '-'));
                        $sheetOco->setCellValue('C' . $linha, (string) $nomeMaquina);
                        $sheetOco->setCellValue('D' . $linha, (string) ($oco->maquina->setor->nome ?? 'N/A'));
                        $sheetOco->setCellValue('E' . $linha, $prioridade);
                        $sheetOco->setCellValue('F' . $linha, $status);
                        $sheetOco->setCellValue('G' . $linha, (string) $nomeProfessor);
                        $sheetOco->setCellValue('H' . $linha, (string) $nomeTecnico);
                        $sheetOco->setCellValue('I' . $linha, Carbon::parse($oco->created_at)->format('d/m/Y H:i'));
                        $linha++;
                    }
                    $sheetOco->getColumnDimension('B')->setWidth(30);
                    $sheetOco->getColumnDimension('C')->setWidth(20);
                }


                // --- ABA 3: CORRETIVAS ---
                if (isset($dados['corretivas']) && $dados['corretivas']->isNotEmpty()) {
                    $sheetCorretivas = $spreadsheet->createSheet();
                    $sheetCorretivas->setTitle('Corretivas');
                    
                    $sheetCorretivas->setCellValue('A1', 'ID da Ocorrência');
                    $sheetCorretivas->setCellValue('B1', 'Máquina');
                    $sheetCorretivas->setCellValue('C1', 'Setor');
                    $sheetCorretivas->setCellValue('D1', 'Técnico');
                    $sheetCorretivas->setCellValue('E1', 'Tempo Reparo (h)');
                    $sheetCorretivas->setCellValue('F1', 'Custo Total (R$)');
                    $sheetCorretivas->setCellValue('G1', 'Data de Conclusão');
                    
                    $linha = 2;
                    foreach ($dados['corretivas'] as $corretiva) {
                        $nomeMaquina = $corretiva->maquina->nome ?? $corretiva->maquina->numeroSerie ?? $corretiva->maquina->codigo ?? 'N/A';
                        $nomeTecnico = $corretiva->tecnico->name ?? $corretiva->tecnico->nome ?? 'N/A';

                        $sheetCorretivas->setCellValue('A' . $linha, $corretiva->ocorrencia_id ?? '-');
                        $sheetCorretivas->setCellValue('B' . $linha, (string) $nomeMaquina);
                        $sheetCorretivas->setCellValue('C' . $linha, (string) ($corretiva->maquina->setor->nome ?? 'N/A'));
                        $sheetCorretivas->setCellValue('D' . $linha, (string) $nomeTecnico);
                        
                        // Garante que tempo é texto/número
                        $tempo = is_object($corretiva->tempo_reparo) ? '-' : ($corretiva->tempo_reparo ?? 0);
                        $sheetCorretivas->setCellValue('E' . $linha, (string) $tempo);
                        
                        // Garante que o custo seja convertido para float/decimal, quebrando objetos estranhos
                        $custo = method_exists($corretiva, 'custoTotal') ? $corretiva->custoTotal() : ($corretiva->custo_total ?? 0);
                        $sheetCorretivas->setCellValue('F' . $linha, (float) $custo);
                        
                        $dataConclusao = $corretiva->created_at ? Carbon::parse($corretiva->created_at)->format('d/m/Y') : '-';
                        $sheetCorretivas->setCellValue('G' . $linha, $dataConclusao);
                        
                        $linha++;
                    }
                }


                // --- ABA 4: PREVENTIVAS ---
                if (isset($dados['preventivas']) && $dados['preventivas']->isNotEmpty()) {
                    $sheetPrev = $spreadsheet->createSheet();
                    $sheetPrev->setTitle('Preventivas');
                    
                    $sheetPrev->setCellValue('A1', 'ID');
                    $sheetPrev->setCellValue('B1', 'Máquina');
                    $sheetPrev->setCellValue('C1', 'Setor');
                    $sheetPrev->setCellValue('D1', 'Técnico');
                    $sheetPrev->setCellValue('E1', 'Periodicidade');
                    $sheetPrev->setCellValue('F1', 'Data Prevista');
                    $sheetPrev->setCellValue('G1', 'Status');
                    $sheetPrev->setCellValue('H1', 'Custo (R$)');

                    $linha = 2;
                    foreach ($dados['preventivas'] as $preventiva) {
                        $nomeMaquina = $preventiva->maquina->nome ?? $preventiva->maquina->numeroSerie ?? $preventiva->maquina->codigo ?? 'N/A';
                        $nomeTecnico = $preventiva->tecnico->name ?? $preventiva->tecnico->nome ?? 'N/A';

                        // TRATATIVA DO ERRO: Trata status e periodicidade para não passarem como objetos Enum
                        $periodicidade = $preventiva->periodicidade instanceof \BackedEnum ? $preventiva->periodicidade->value : (string) ($preventiva->periodicidade ?? '-');
                        $statusPrev = $preventiva->status instanceof \BackedEnum ? $preventiva->status->value : (string) ($preventiva->status ?? '-');

                        $sheetPrev->setCellValue('A' . $linha, $preventiva->id);
                        $sheetPrev->setCellValue('B' . $linha, (string) $nomeMaquina);
                        $sheetPrev->setCellValue('C' . $linha, (string) ($preventiva->maquina->setor->nome ?? 'N/A'));
                        $sheetPrev->setCellValue('D' . $linha, (string) $nomeTecnico);
                        $sheetPrev->setCellValue('E' . $linha, $periodicidade);
                        $sheetPrev->setCellValue('F' . $linha, Carbon::parse($preventiva->data_prevista)->format('d/m/Y'));
                        $sheetPrev->setCellValue('G' . $linha, $statusPrev);
                        $sheetPrev->setCellValue('H' . $linha, (float) ($preventiva->custo ?? 0));
                        $linha++;
                    }
                }

                $writer = new Xlsx($spreadsheet);

                return response()->streamDownload(function () use ($writer) {
                    $writer->save('php://output');
                }, 'Relatorio_Manutencao_Completo_' . date('Y_m_d_His') . '.xlsx');
            }),
    ];
}
    
}