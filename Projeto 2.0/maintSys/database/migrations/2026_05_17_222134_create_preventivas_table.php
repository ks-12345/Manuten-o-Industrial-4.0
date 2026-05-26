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
            $table->foreignId('maquina_id')->constrained('maquinas')->cascadeOnDelete();
            $table->foreignId('tecnico_id')->nullable()->constrained('users');
            $table->date('data_prevista');
            $table->date('data_realizada')->nullable();
            $table->string('status')->default('pendente');
            $table->string('periodicidade');
            $table->text('observacoes')->nullable();
            $table->text('resumo')->nullable();
            $table->integer('tempo_realizado_minutos')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('preventivas');
    }
};
