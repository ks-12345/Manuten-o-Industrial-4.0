// database/migrations/2024_01_01_000011_create_historicos_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('historicos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users');
            $table->nullableMorphs('historiavel');
            $table->string('tipo'); // ocorrencia | inspecao | preventiva | corretiva
            $table->string('acao');
            $table->text('descricao')->nullable();
            $table->json('dados_anteriores')->nullable();
            $table->json('dados_novos')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('historicos');
    }
};