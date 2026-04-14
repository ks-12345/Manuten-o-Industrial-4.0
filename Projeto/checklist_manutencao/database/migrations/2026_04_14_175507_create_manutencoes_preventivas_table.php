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
Schema::create('manutencoes_preventivas', function (Blueprint $table) {
    $table->id();
    $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
    $table->date('data_ultima')->nullable();
    $table->date('data_proxima')->nullable();
    $table->enum('status', ['pendente', 'agendada', 'concluida'])->default('pendente');
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('manutencoes_preventivas');
    }
};
