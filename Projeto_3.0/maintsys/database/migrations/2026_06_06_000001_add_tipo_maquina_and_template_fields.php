<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tipos_maquina', function (Blueprint $table) {
            $table->id();
            $table->string('nome')->unique();
            $table->text('descricao')->nullable();
            $table->boolean('ativo')->default(true);
            $table->timestamps();
        });

        Schema::table('maquinas', function (Blueprint $table) {
            $table->foreignId('tipo_maquina_id')
                ->nullable()
                ->after('setor_id')
                ->constrained('tipos_maquina')
                ->nullOnDelete();
        });

        Schema::table('checklist_modelos', function (Blueprint $table) {
            $table->foreignId('tipo_maquina_id')
                ->nullable()
                ->after('maquina_id')
                ->constrained('tipos_maquina')
                ->nullOnDelete();

            $table->boolean('template_padrao')
                ->default(false)
                ->after('tipo_maquina_id');

            $table->index(['tipo', 'maquina_id']);
            $table->index(['tipo', 'tipo_maquina_id', 'template_padrao'], 'checklist_modelos_template_idx');
        });
    }

    public function down(): void
    {
        Schema::table('checklist_modelos', function (Blueprint $table) {
            $table->dropIndex('checklist_modelos_template_idx');
            $table->dropIndex(['tipo', 'maquina_id']);
            $table->dropConstrainedForeignId('tipo_maquina_id');
            $table->dropColumn('template_padrao');
        });

        Schema::table('maquinas', function (Blueprint $table) {
            $table->dropConstrainedForeignId('tipo_maquina_id');
        });

        Schema::dropIfExists('tipos_maquina');
    }
};
