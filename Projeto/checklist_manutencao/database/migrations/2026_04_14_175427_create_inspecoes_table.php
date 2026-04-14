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
Schema::create('inspecoes', function (Blueprint $table) {
    $table->id();
    $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
    $table->foreignId('tecnico_id')->constrained('tecnicos')->cascadeOnDelete();
    $table->dateTime('data_inspecao');
    $table->text('observacoes')->nullable();
    $table->enum('status', ['aprovado', 'manutencao'])->default('aprovado');
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inspecoes');
    }
};
