<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Relacionamento POLIMÓRFICO: Inspecao | Corretiva | Preventiva
        Schema::create('checklist_respostas', function (Blueprint $table) {
    $table->id();

    $table->foreignId('checklist_pergunta_id')
          ->constrained('checklist_perguntas')
          ->restrictOnDelete();

    $table->morphs('checklistable');

    $table->text('resposta')->nullable();
    $table->text('observacao')->nullable();
    $table->string('foto')->nullable();
    $table->timestamps();
});
    }

    public function down(): void
    {
        Schema::dropIfExists('checklist_respostas');
    }
};