<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orcamentos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('solicitacao_peca_id')
                  ->constrained('solicitacoes_pecas')
                  ->restrictOnDelete();
            $table->string('empresa');
            $table->string('contato')->nullable();
            $table->decimal('valor', 10, 2);
            $table->integer('prazo_entrega')->nullable(); // em dias
            $table->text('observacoes')->nullable();
            $table->boolean('aprovado')->default(false);
            $table->foreignId('aprovado_por_id')
                  ->nullable()
                  ->constrained('users')
                  ->nullOnDelete();
            $table->timestamp('aprovado_em')->nullable();
            $table->string('arquivo')->nullable(); // PDF do orçamento no Storage
            $table->timestamps();
            $table->softDeletes();

            $table->index('solicitacao_peca_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('orcamentos');
    }
};