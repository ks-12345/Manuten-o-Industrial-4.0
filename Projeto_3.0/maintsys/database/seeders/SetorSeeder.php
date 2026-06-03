<?php

namespace Database\Seeders;

use App\Models\Setor;
use App\Models\User;
use Illuminate\Database\Seeder;

class SetorSeeder extends Seeder
{
    public function run(): void
    {
        $responsavel = User::role('admin')->first();

        $setores = [
            ['nome' => 'Produção',      'codigo' => 'PROD-01', 'localizacao' => 'Galpão A'],
            ['nome' => 'Usinagem',      'codigo' => 'USIN-01', 'localizacao' => 'Galpão B'],
            ['nome' => 'Manutenção',    'codigo' => 'MANT-01', 'localizacao' => 'Oficina'],
            ['nome' => 'Laboratório',   'codigo' => 'LAB-01',  'localizacao' => 'Bloco C'],
            ['nome' => 'Almoxarifado',  'codigo' => 'ALM-01',  'localizacao' => 'Galpão A - Lateral'],
        ];

        foreach ($setores as $data) {
            Setor::firstOrCreate(
                ['codigo' => $data['codigo']],
                array_merge($data, [
                    'responsavel_id' => $responsavel?->id,
                    'ativo'          => true,
                ])
            );
        }
    }
}