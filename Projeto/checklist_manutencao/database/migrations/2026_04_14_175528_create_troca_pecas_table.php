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
Schema::create('troca_pecas', function (Blueprint $table) {
    $table->id();
    $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
    $table->foreignId('peca_id')->constrained('pecas')->cascadeOnDelete();
    $table->date('data_troca');
    $table->text('observacoes')->nullable();
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('troca_pecas');
    }
};
