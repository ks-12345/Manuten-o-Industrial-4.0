<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
Schema::create('manutencoes_corretivas', function (Blueprint $table) {
    $table->id();
    $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
    $table->foreignId('tecnico_id')->constrained('tecnicos')->cascadeOnDelete();
    $table->string('tipo_falha');
    $table->enum('gravidade', ['baixa', 'media', 'alta'])->default('media');
    $table->enum('status', ['aberto', 'andamento', 'concluido'])->default('aberto');
    $table->text('descricao')->nullable();
    $table->dateTime('data_abertura');
    $table->dateTime('data_fechamento')->nullable();
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('manutencoes_corretivas');
    }
};
