<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('historicos', function (Blueprint $table) {
            $table->id();

            $table->morphs('historiavel');

            $table->foreignId('user_id')
                ->nullable()
                ->constrained('users')
                ->nullOnDelete();

            $table->string('acao');
            $table->text('descricao');

            $table->json('dados_anteriores')->nullable();
            $table->json('dados_novos')->nullable();

            $table->string('ip')->nullable();

            $table->timestamps();

            $table->index('user_id');
            $table->index('acao');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('historicos');
    }
};