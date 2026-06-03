<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('corretivas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('maquina_id')->constrained('maquinas')->restrictOnDelete();
            $table->foreignId('ocorrencia_id')
                  ->nullable()
                  ->constrained('ocorrencias')
                  ->nullOnDelete();
            $table->foreignId('tecnico_id')->constrained('users')->restrictOnDelete();
            $table->string('tipo')->default('direta'); // enum TipoCorretiva
            $table->text('problema');
            $table->text('solucao')->nullable();
            $table->text('resumo')->nullable();
            $table->integer('tempo_reparo')->nullable(); // em minutos
            $table->decimal('custo_pecas', 10, 2)->default(0);
            $table->decimal('custo_mao_obra', 10, 2)->default(0);
            $table->string('status')->default('em_andamento'); // em_andamento | finalizada
            $table->timestamp('inicio')->nullable();
            $table->timestamp('fim')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('maquina_id');
            $table->index('ocorrencia_id');
            $table->index('tecnico_id');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('corretivas');
    }
};