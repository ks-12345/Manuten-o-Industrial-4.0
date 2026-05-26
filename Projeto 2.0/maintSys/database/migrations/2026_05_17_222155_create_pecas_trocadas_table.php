<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pecas_trocadas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('corretiva_id')->constrained('corretivas')->cascadeOnDelete();
            $table->foreignId('maquina_id')->constrained('maquinas');
            $table->foreignId('tecnico_id')->constrained('users');
            $table->string('nome_peca');
            $table->string('codigo_peca')->nullable();
            $table->integer('quantidade')->default(1);
            $table->text('motivo_troca');
            $table->text('observacoes')->nullable();
            $table->date('data_troca');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pecas_trocadas');
    }
};
