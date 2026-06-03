<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('checklist_modelos', function (Blueprint $table) {
            $table->id();
            $table->string('nome');
            $table->text('descricao')->nullable();
            $table->string('tipo'); // enum TipoChecklist
            $table->foreignId('maquina_id')
                  ->nullable()
                  ->constrained('maquinas')
                  ->nullOnDelete(); // null = modelo global
            $table->boolean('ativo')->default(true);
            $table->timestamps();
            $table->softDeletes();

            $table->index('tipo');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('checklist_modelos');
    }
};