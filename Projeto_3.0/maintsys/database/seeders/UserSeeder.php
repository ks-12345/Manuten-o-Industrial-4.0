<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        // Admin
        $admin = User::firstOrCreate(
            ['email' => 'admin@maintsys.com.br'],
            [
                'name'     => 'Administrador',
                'password' => Hash::make('password'),
                'ativo'    => true,
            ]
        );
        $admin->assignRole('admin');

        // Professor
        $professor = User::firstOrCreate(
            ['email' => 'professor@maintsys.com.br'],
            [
                'name'     => 'Prof. João Silva',
                'password' => Hash::make('password'),
                'ativo'    => true,
            ]
        );
        $professor->assignRole('professor');

        // Técnico
        $tecnico = User::firstOrCreate(
            ['email' => 'tecnico@maintsys.com.br'],
            [
                'name'     => 'Carlos Técnico',
                'password' => Hash::make('password'),
                'ativo'    => true,
            ]
        );
        $tecnico->assignRole('tecnico');

        // Professor que também é Técnico (dual-role)
        $dual = User::firstOrCreate(
            ['email' => 'prof.tecnico@maintsys.com.br'],
            [
                'name'     => 'Prof. Ana Costa',
                'password' => Hash::make('password'),
                'ativo'    => true,
            ]
        );
        $dual->assignRole('professor');
        $dual->assignRole('tecnico');

        // Usuário temporário de exemplo
        $temp = User::firstOrCreate(
            ['email' => 'temp@maintsys.com.br'],
            [
                'name'           => 'Usuário Temporário',
                'password'       => Hash::make('password'),
                'is_temporary'   => true,
                'data_expiracao' => now()->addDays(30),
                'ativo'          => true,
                'criado_por_id'  => $admin->id,
            ]
        );
        $temp->assignRole('professor');
    }
}