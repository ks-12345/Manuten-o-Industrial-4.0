<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('maquinas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('setor_id')->constrained('setores')->restrictOnDelete();
            $table->string('nome');
            $table->string('patrimonio', 50)->unique()->nullable();
            $table->string('fabricante')->nullable();
            $table->string('modelo')->nullable();
            $table->string('serie')->nullable();
            $table->string('tensao', 20)->nullable();    // ex: 220V / 380V
            $table->string('potencia', 20)->nullable();  // ex: 5kW
            $table->string('foto')->nullable();           // caminho no Supabase Storage
            $table->string('status')->default('operando'); // enum StatusMaquina
            $table->text('observacoes')->nullable();
            $table->date('ultima_preventiva')->nullable();
            $table->string('periodicidade_preventiva')->nullable(); // enum PeriodicidadePreventiva

            // Posição no mapa visual
            $table->decimal('posicao_x', 8, 2)->default(0);
            $table->decimal('posicao_y', 8, 2)->default(0);

            $table->timestamps();
            $table->softDeletes();

            $table->index('setor_id');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('maquinas');
    }
};