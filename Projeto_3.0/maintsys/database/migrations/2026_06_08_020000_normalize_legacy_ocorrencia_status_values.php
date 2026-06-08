<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::table('ocorrencias')
            ->where('status', 'em_analise')
            ->update(['status' => 'em_inspecao']);

        DB::table('ocorrencias')
            ->where('status', 'em_corretiva')
            ->update(['status' => 'corretiva']);

        DB::table('ocorrencias')
            ->where('status', 'finalizada')
            ->update(['status' => 'concluida']);

        DB::table('ocorrencias')
            ->where('status', 'aguardando_peca')
            ->update(['status' => 'aguardando_orcamento']);
    }

    public function down(): void
    {
        DB::table('ocorrencias')
            ->where('status', 'em_inspecao')
            ->update(['status' => 'em_analise']);

        DB::table('ocorrencias')
            ->where('status', 'corretiva')
            ->update(['status' => 'em_corretiva']);

        DB::table('ocorrencias')
            ->where('status', 'concluida')
            ->update(['status' => 'finalizada']);
    }
};
