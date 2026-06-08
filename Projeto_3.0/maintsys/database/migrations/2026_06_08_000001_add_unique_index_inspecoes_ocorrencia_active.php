<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Garante que exista no máximo uma inspeção ativa (fim IS NULL) por ocorrência.
        // Isso protege contra duplicação por race condition.
        Schema::table('inspecoes', function (Blueprint $table) {
            $table->unique(
                ['ocorrencia_id', 'fim'],
                'inspecoes_ocorrencia_id_fim_unique'
            );
        });
    }

    public function down(): void
    {
        Schema::table('inspecoes', function (Blueprint $table) {
            $table->dropUnique('inspecoes_ocorrencia_id_fim_unique');
        });
    }
};

