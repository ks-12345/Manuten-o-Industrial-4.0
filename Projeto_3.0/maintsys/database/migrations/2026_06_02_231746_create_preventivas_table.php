<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('preventivas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('maquina_id')->constrained('maquinas')->restrictOnDelete();
            $table->foreignId('tecnico_id')
                  ->nullable()
                  ->constrained('users')
                  ->nullOnDelete();
            $table->string('periodicidade'); // enum PeriodicidadePreventiva
            $table->date('data_prevista');
            $table->date('data_realizada')->nullable();
            $table->text('observacoes')->nullable();
            $table->string('status')->default('pendente'); // pendente | em_andamento | realizada | atrasada
            $table->integer('tempo_execucao')->nullable(); // em minutos
            $table->decimal('custo', 10, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();

            $table->index('maquina_id');
            $table->index('tecnico_id');
            $table->index('data_prevista');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('preventivas');
    }
};