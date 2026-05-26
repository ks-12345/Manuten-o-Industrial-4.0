<?php

namespace Tests\Feature;

use App\Enums\StatusCorretiva;
use App\Enums\StatusInspecao;
use App\Enums\StatusMaquina;
use App\Enums\StatusOcorrencia;
use App\Enums\TipoChecklist;
use App\Livewire\Corretiva\ExecutarChecklistCorretiva;
use App\Livewire\Inspecao\ExecutarChecklistInspecao;
use App\Models\ChecklistModelo;
use App\Models\ChecklistResposta;
use App\Models\Corretiva;
use App\Models\Maquina;
use App\Models\Ocorrencia;
use App\Models\PecaTrocada;
use App\Models\User;
use App\Services\CorretivaService;
use App\Services\InspecaoService;
use App\Services\OcorrenciaService;
use Database\Seeders\DatabaseSeeder;
use Livewire\Livewire;
use Tests\TestCase;

class MaintenanceFlowTest extends TestCase
{
    public function test_fluxo_ocorrencia_inspecao_corretiva_com_checklists_dinamicos(): void
    {
        if (! extension_loaded('pdo_sqlite')) {
            $this->markTestSkipped('A extensao pdo_sqlite nao esta habilitada neste ambiente PHP.');
        }

        $this->artisan('migrate:fresh')->assertExitCode(0);
        $this->seed(DatabaseSeeder::class);

        $tecnico = User::where('email', 'tecnico@maintSys.com')->firstOrFail();
        $supervisor = User::where('email', 'professor@maintSys.com')->firstOrFail();
        $maquina = Maquina::query()->with('setor')->firstOrFail();

        $this->actingAs($tecnico);

        $ocorrencia = Ocorrencia::query()->create([
            'maquina_id' => $maquina->id,
            'setor_id' => $maquina->setor_id,
            'aberto_por' => $supervisor->id,
            'titulo' => 'Falha no acionamento do eixo',
            'descricao' => 'Supervisor reportou falha intermitente no acionamento principal.',
            'prioridade' => 'alta',
            'status' => StatusOcorrencia::Aberto,
        ]);

        app(OcorrenciaService::class)->assumir($ocorrencia);
        $this->assertSame(StatusOcorrencia::EmAnalise, $ocorrencia->refresh()->status);
        $this->assertSame(StatusMaquina::Manutencao, $maquina->refresh()->status);

        $inspecao = app(InspecaoService::class)->iniciar($ocorrencia);
        $respostasInspecao = $this->respostasParaChecklist($maquina, TipoChecklist::Inspecao);

        Livewire::test(ExecutarChecklistInspecao::class, ['inspecaoId' => (string) $inspecao->id])
            ->set('respostas', $respostasInspecao)
            ->set('outro_problema', true)
            ->set('descricao_outro_problema', 'Folga axial acima do limite observado.')
            ->call('salvarChecklist')
            ->assertHasNoErrors();

        $this->assertSame(StatusInspecao::Finalizada, $inspecao->refresh()->status);
        $this->assertTrue($inspecao->outro_problema);
        $this->assertCount(count($respostasInspecao), ChecklistResposta::where('checklistavel_type', $inspecao::class)->where('checklistavel_id', $inspecao->id)->get());

        $corretiva = app(CorretivaService::class)->criarAPartirDaInspecao($inspecao, []);
        $respostasCorretiva = $this->respostasParaChecklist($maquina, TipoChecklist::Corretiva);

        Livewire::test(ExecutarChecklistCorretiva::class, ['corretivaId' => (string) $corretiva->id])
            ->set('respostas', $respostasCorretiva)
            ->set('solucao_aplicada', 'Substituicao de rolamento e ajuste do conjunto.')
            ->set('resumo_tecnico', 'Falha eliminada apos teste funcional.')
            ->set('tempo_reparo_minutos', 75)
            ->set('pecas', [[
                'nome_peca' => 'Rolamento 6205 ZZ',
                'codigo_peca' => 'ROL-6205-ZZ',
                'quantidade' => 1,
                'motivo_troca' => 'Folga e ruido acima do aceitavel',
                'observacoes' => 'Registro historico, sem controle de estoque.',
            ]])
            ->call('salvarChecklist')
            ->assertHasNoErrors();

        $this->assertSame(StatusCorretiva::Finalizada, $corretiva->refresh()->status);
        $this->assertSame(StatusOcorrencia::Finalizado, $ocorrencia->refresh()->status);
        $this->assertSame(StatusMaquina::Operando, $maquina->refresh()->status);
        $this->assertDatabaseHas(PecaTrocada::class, [
            'corretiva_id' => $corretiva->id,
            'maquina_id' => $maquina->id,
            'nome_peca' => 'Rolamento 6205 ZZ',
            'quantidade' => 1,
        ]);
        $this->assertDatabaseHas(Corretiva::class, [
            'id' => $corretiva->id,
            'tempo_reparo_minutos' => 75,
        ]);
    }

    private function respostasParaChecklist(Maquina $maquina, TipoChecklist $tipo): array
    {
        $modelo = ChecklistModelo::query()
            ->where('maquina_id', $maquina->id)
            ->where('tipo', $tipo)
            ->with('perguntas')
            ->firstOrFail();

        return $modelo->perguntas
            ->mapWithKeys(fn ($pergunta): array => [
                $pergunta->id => [
                    'conforme' => true,
                    'resposta' => 'ok',
                    'observacao' => 'Conferido em teste automatizado.',
                ],
            ])
            ->toArray();
    }
}
