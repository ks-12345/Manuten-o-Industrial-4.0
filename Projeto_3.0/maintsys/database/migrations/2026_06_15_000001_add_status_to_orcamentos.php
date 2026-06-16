<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orcamentos', function (Blueprint $table) {
            $table->string('status')->default('pendente')->after('aprovado');
        });

        // Sincronizar dados existentes com o novo campo
        DB::statement("
            UPDATE orcamentos
            SET status = CASE
                WHEN aprovado = true  THEN 'aprovado'
                WHEN aprovado = false AND aprovado_em IS NOT NULL THEN 'negado'
                ELSE 'pendente'
            END
        ");
    }

    public function down(): void
    {
        Schema::table('orcamentos', function (Blueprint $table) {
            $table->dropColumn('status');
        });
    }
};