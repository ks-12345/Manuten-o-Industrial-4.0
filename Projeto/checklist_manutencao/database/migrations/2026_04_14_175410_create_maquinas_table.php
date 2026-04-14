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
  Schema::create('maquinas', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->string('codigo')->unique();
    $table->foreignId('localizacao_id')->nullable()->constrained('localizacoes')->nullOnDelete();
    $table->enum('status', ['funcionando', 'quebrada', 'manutencao', 'risco'])->default('funcionando');
    $table->date('data_aquisicao')->nullable();
    $table->text('descricao')->nullable();
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('maquinas');
    }
};
