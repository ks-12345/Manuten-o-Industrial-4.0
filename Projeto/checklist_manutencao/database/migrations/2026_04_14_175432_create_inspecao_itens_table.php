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
Schema::create('inspecao_itens', function (Blueprint $table) {
    $table->id();
    $table->foreignId('inspecao_id')->constrained('inspecoes')->cascadeOnDelete();
    $table->enum('item', ['lubrificacao', 'temperatura', 'ruido', 'limpeza', 'pecas']);
    $table->enum('status', ['ok', 'problema'])->default('ok');
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inspecao_itens');
    }
};
