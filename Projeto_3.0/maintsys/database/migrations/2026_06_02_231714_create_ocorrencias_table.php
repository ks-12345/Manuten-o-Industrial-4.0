<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ocorrencias', function (Blueprint $table) {
            $table->id();
            $table->string('codigo', 20)->unique(); // OC-2024-0001
            $table->foreignId('maquina_id')->constrained('maquinas')->restrictOnDelete();
            $table->foreignId('professor_id')->constrained('users')->restrictOnDelete();
            $table->foreignId('tecnico_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('titulo');
            $table->text('descricao');
            $table->string('prioridade')->default('media'); // enum PrioridadeOcorrencia
            $table->string('status')->default('aberta');    // enum StatusOcorrencia
            $table->text('observacoes_internas')->nullable();
            $table->timestamp('assumida_em')->nullable();
            $table->timestamp('finalizada_em')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('maquina_id');
            $table->index('professor_id');
            $table->index('tecnico_id');
            $table->index('status');
            $table->index('prioridade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ocorrencias');
    }
};