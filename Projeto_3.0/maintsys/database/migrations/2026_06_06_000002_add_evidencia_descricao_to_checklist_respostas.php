<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('checklist_respostas', function (Blueprint $table) {
            $table->string('evidencia')->nullable()->after('foto');
            $table->text('descricao')->nullable()->after('evidencia');
        });

        DB::table('checklist_respostas')
            ->whereNotNull('foto')
            ->whereNull('evidencia')
            ->update(['evidencia' => DB::raw('foto')]);

        DB::table('checklist_respostas')
            ->whereNotNull('observacao')
            ->whereNull('descricao')
            ->update(['descricao' => DB::raw('observacao')]);
    }

    public function down(): void
    {
        Schema::table('checklist_respostas', function (Blueprint $table) {
            $table->dropColumn(['evidencia', 'descricao']);
        });
    }
};
