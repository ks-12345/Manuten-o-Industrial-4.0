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
// database/migrations/..._create_localizacoes_table.php
Schema::create('localizacoes', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->float('pos_x')->default(0);
    $table->float('pos_y')->default(0);
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('localizacoes');
    }
};
