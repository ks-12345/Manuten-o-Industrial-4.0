// database/migrations/2024_01_01_000003_create_ocorrencias_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('ocorrencias', function (Blueprint $table) {
            $table->id();
            $table->string('codigo')->unique();
            $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
            $table->foreignId('setor_id')->constrained('setores');
            $table->foreignId('aberto_por')->constrained('users');
            $table->foreignId('tecnico_id')->nullable()->constrained('users');
            $table->string('titulo');
            $table->text('descricao');
            $table->string('prioridade')->default('media');
            $table->string('status')->default('aberto');
            $table->string('foto')->nullable();
            $table->timestamp('assumido_em')->nullable();
            $table->timestamp('finalizado_em')->nullable();
            $table->text('observacoes_tecnico')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ocorrencias');
    }
};