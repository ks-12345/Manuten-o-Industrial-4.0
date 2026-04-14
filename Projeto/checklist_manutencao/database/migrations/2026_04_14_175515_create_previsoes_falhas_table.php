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
Schema::create('previsoes_falhas', function (Blueprint $table) {
    $table->id();
    $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
    $table->enum('nivel_risco', ['baixo', 'medio', 'alto'])->default('baixo');
    $table->text('descricao')->nullable();
    $table->date('data_analise');
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('previsoes_falhas');
    }
};
