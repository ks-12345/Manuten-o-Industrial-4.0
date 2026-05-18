// database/migrations/2024_01_01_000004_create_inspecoes_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('inspecoes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ocorrencia_id')->constrained('ocorrencias')->cascadeOnDelete();
            $table->foreignId('maquina_id')->constrained('maquinas');
            $table->foreignId('tecnico_id')->constrained('users');
            $table->text('diagnostico')->nullable();
            $table->text('observacoes')->nullable();
            $table->boolean('outro_problema')->default(false);
            $table->text('descricao_outro_problema')->nullable();
            $table->string('status')->default('em_andamento');
            $table->timestamp('iniciado_em')->nullable();
            $table->timestamp('finalizado_em')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('inspecoes');
    }
};