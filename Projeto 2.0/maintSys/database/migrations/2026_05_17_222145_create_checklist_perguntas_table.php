// database/migrations/2024_01_01_000008_create_checklist_perguntas_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('checklist_perguntas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('checklist_modelo_id')->constrained('checklist_modelos')->cascadeOnDelete();
            $table->string('pergunta');
            $table->string('tipo_resposta'); // sim_nao | ok_problema | texto | observacao | foto
            $table->boolean('obrigatorio')->default(true);
            $table->integer('ordem')->default(0);
            $table->text('ajuda')->nullable();
            $table->boolean('ativo')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('checklist_perguntas');
    }
};