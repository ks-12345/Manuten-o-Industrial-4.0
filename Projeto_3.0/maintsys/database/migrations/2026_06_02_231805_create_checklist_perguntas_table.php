<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('checklist_perguntas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('checklist_modelo_id')
                  ->constrained('checklist_modelos')
                  ->cascadeOnDelete();
            $table->string('pergunta');
            $table->string('tipo_resposta'); // enum TipoResposta
            $table->boolean('obrigatoria')->default(true);
            $table->integer('ordem')->default(0);
            $table->text('ajuda')->nullable(); // texto de ajuda para o técnico
            $table->timestamps();

            $table->index('checklist_modelo_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('checklist_perguntas');
    }
};