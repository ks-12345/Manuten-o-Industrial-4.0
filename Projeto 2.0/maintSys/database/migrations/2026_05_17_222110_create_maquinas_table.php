// database/migrations/2024_01_01_000002_create_maquinas_table.php
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('maquinas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('setor_id')->constrained('setores')->cascadeOnDelete();
            $table->string('nome');
            $table->string('modelo')->nullable();
            $table->string('fabricante')->nullable();
            $table->string('numero_serie')->unique()->nullable();
            $table->string('patrimonio')->unique()->nullable();
            $table->string('tensao')->nullable();
            $table->string('potencia')->nullable();
            $table->date('data_aquisicao')->nullable();
            $table->date('data_instalacao')->nullable();
            $table->string('status')->default('operando');
            $table->string('foto')->nullable();
            $table->text('observacoes')->nullable();
            $table->boolean('ativo')->default(true);

            // Preventiva
            $table->string('periodicidade_preventiva')->nullable();
            $table->date('ultima_preventiva')->nullable();
            $table->date('proxima_preventiva')->nullable();

            // Posição no mapa
            $table->integer('pos_x')->nullable();
            $table->integer('pos_y')->nullable();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('maquinas');
    }
};