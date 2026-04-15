<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    // database/seeders/DatabaseSeeder.php
public function run(): void
{
    // Localizações
    $loc = \App\Models\Localizacao::create(['nome' => 'Galpão A', 'pos_x' => 10, 'pos_y' => 20]);

    // Máquinas
    \App\Models\Maquina::create([
        'nome' => 'Fresadora Universal 01',
        'codigo' => 'FR-001',
        'localizacao_id' => $loc->id,
        'status' => 'funcionando',
        'data_aquisicao' => '2022-01-15',
    ]);

    // Técnico
    \App\Models\Tecnico::create([
        'nome' => 'João Silva',
        'email' => 'joao@senai.br',
        'tipo' => 'tecnico',
    ]);
}
}
