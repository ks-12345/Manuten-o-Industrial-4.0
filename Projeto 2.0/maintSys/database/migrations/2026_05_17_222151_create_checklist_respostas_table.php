// database/migrations/2024_01_01_000009_create_checklist_respostas_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('checklist_respostas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('checklist_pergunta_id')->constrained('checklist_perguntas');
            $table->foreignId('tecnico_id')->constrained('users');
            $table->nullableMorphs('checklistavel'); // inspecao | corretiva | preventiva
            $table->string('resposta');
            $table->text('observacao')->nullable();
            $table->string('foto')->nullable();
            $table->boolean('conforme')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('checklist_respostas');
    }
};