// database/migrations/2024_01_01_000005_create_corretivas_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('corretivas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ocorrencia_id')->constrained('ocorrencias')->cascadeOnDelete();
            $table->foreignId('inspecao_id')->nullable()->constrained('inspecoes');
            $table->foreignId('maquina_id')->constrained('maquinas');
            $table->foreignId('tecnico_id')->constrained('users');
            $table->text('problema_identificado');
            $table->text('solucao_aplicada')->nullable();
            $table->text('resumo_tecnico')->nullable();
            $table->text('observacoes')->nullable();
            $table->string('foto_antes')->nullable();
            $table->string('foto_depois')->nullable();
            $table->integer('tempo_reparo_minutos')->nullable();
            $table->string('status')->default('em_andamento');
            $table->timestamp('iniciado_em')->nullable();
            $table->timestamp('finalizado_em')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('corretivas');
    }
};