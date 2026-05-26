<?php

namespace Database\Seeders;

use App\Models\Maquina;
use App\Models\Setor;
use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Roles
        $admin = Role::firstOrCreate(['name' => 'admin',      'guard_name' => 'web']);
        $tecnico = Role::firstOrCreate(['name' => 'tecnico',    'guard_name' => 'web']);
        $supervisor = Role::firstOrCreate(['name' => 'supervisor', 'guard_name' => 'web']);

        // Usuários
        $adminUser = User::firstOrCreate(
            ['email' => 'admin@maintSys.com'],
            ['name' => 'Administrador', 'password' => bcrypt('password')]
        );
        $adminUser->assignRole($admin);

        $tecnicoUser = User::firstOrCreate(
            ['email' => 'tecnico@maintSys.com'],
            ['name' => 'João Técnico', 'password' => bcrypt('password')]
        );
        $tecnicoUser->assignRole($tecnico);

        $supervisorUser = User::firstOrCreate(
            ['email' => 'professor@maintSys.com'],
            ['name' => 'Prof. Carlos', 'password' => bcrypt('password')]
        );
        $supervisorUser->assignRole($supervisor);

        // Setores
        $setores = [
            ['nome' => 'Usinagem 01',      'codigo' => 'US01', 'localizacao' => 'Bloco A'],
            ['nome' => 'Usinagem 02',      'codigo' => 'US02', 'localizacao' => 'Bloco A'],
            ['nome' => 'CNC',              'codigo' => 'CNC',  'localizacao' => 'Bloco B'],
            ['nome' => 'Eletromecânica',   'codigo' => 'ELET', 'localizacao' => 'Bloco C'],
            ['nome' => 'Solda',            'codigo' => 'SOLD', 'localizacao' => 'Bloco D'],
        ];

        foreach ($setores as $s) {
            $setor = Setor::firstOrCreate(['codigo' => $s['codigo']], $s);

            // Máquinas por setor
            Maquina::firstOrCreate(
                ['patrimonio' => $s['codigo'].'-001'],
                [
                    'setor_id' => $setor->id,
                    'nome' => 'Torno CNC '.$s['codigo'],
                    'modelo' => 'TC-2000',
                    'fabricante' => 'Romi',
                    'patrimonio' => $s['codigo'].'-001',
                    'tensao' => '220V',
                    'status' => 'operando',
                    'periodicidade_preventiva' => 'mensal',
                    'proxima_preventiva' => now()->addDays(15)->toDateString(),
                ]
            );
        }

        $this->call(MaintSysDemoChecklistSeeder::class);
    }
}
