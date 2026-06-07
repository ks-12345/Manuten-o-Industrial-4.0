<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('checklist_respostas', function (Blueprint $table) {
            // Adicionar coluna de resposta padronizada como string (SQLite compatibility)
            $table->string('resposta_enum')->nullable()->after('resposta')
                ->comment('conforme, nao_conforme, nao_aplicavel');
            $table->index('resposta_enum');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('checklist_respostas', function (Blueprint $table) {
            $table->dropIndex(['resposta_enum']);
            $table->dropColumn('resposta_enum');
        });
    }
};
