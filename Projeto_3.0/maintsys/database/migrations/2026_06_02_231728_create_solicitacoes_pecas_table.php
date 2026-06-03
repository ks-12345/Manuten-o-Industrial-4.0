<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('solicitacoes_pecas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('inspecao_id')->constrained('inspecoes')->restrictOnDelete();
            $table->foreignId('maquina_id')->constrained('maquinas')->restrictOnDelete();
            $table->string('nome_peca');
            $table->integer('quantidade')->default(1);
            $table->text('descricao')->nullable();
            $table->string('referencia')->nullable();
            $table->string('status')->default('pendente'); // enum StatusSolicitacaoPeca
            $table->decimal('valor_total_aprovado', 10, 2)->nullable();
            $table->timestamp('peca_recebida_em')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('inspecao_id');
            $table->index('maquina_id');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('solicitacoes_pecas');
    }
};