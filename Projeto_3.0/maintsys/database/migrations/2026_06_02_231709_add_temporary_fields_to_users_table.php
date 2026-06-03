<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->boolean('is_temporary')->default(false)->after('remember_token');
            $table->timestamp('data_expiracao')->nullable()->after('is_temporary');
            $table->boolean('ativo')->default(true)->after('data_expiracao');
            $table->string('avatar')->nullable()->after('ativo');
            $table->foreignId('criado_por_id')
                  ->nullable()
                  ->constrained('users')
                  ->nullOnDelete()
                  ->after('avatar');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'is_temporary',
                'data_expiracao',
                'ativo',
                'avatar',
                'criado_por_id',
            ]);
        });
    }
};