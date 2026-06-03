<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesPermissionsSeeder extends Seeder
{
    public function run(): void
    {
        // Limpar cache
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // ── Permissions ──────────────────────────────────────
        $permissions = [
            // Usuários
            'users.view', 'users.create', 'users.edit', 'users.delete',
            'users.create_temporary',

            // Setores
            'setores.view', 'setores.create', 'setores.edit', 'setores.delete',

            // Máquinas
            'maquinas.view', 'maquinas.create', 'maquinas.edit', 'maquinas.delete',
            'maquinas.map',

            // Ocorrências
            'ocorrencias.view', 'ocorrencias.view_own',
            'ocorrencias.create', 'ocorrencias.edit', 'ocorrencias.delete',
            'ocorrencias.assumir', 'ocorrencias.cancelar',

            // Inspeções
            'inspecoes.view', 'inspecoes.create', 'inspecoes.edit',
            'inspecoes.executar',

            // Solicitações de Peças
            'solicitacoes_pecas.view', 'solicitacoes_pecas.create',
            'solicitacoes_pecas.edit', 'solicitacoes_pecas.delete',

            // Orçamentos
            'orcamentos.view', 'orcamentos.create',
            'orcamentos.edit', 'orcamentos.aprovar',

            // Corretivas
            'corretivas.view', 'corretivas.create', 'corretivas.edit',
            'corretivas.executar',

            // Preventivas
            'preventivas.view', 'preventivas.create', 'preventivas.edit',
            'preventivas.executar',

            // Checklists
            'checklists.view', 'checklists.create', 'checklists.edit',
            'checklists.delete',

            // Dashboards e Indicadores
            'dashboard.view', 'indicadores.view',
        ];

        foreach ($permissions as $perm) {
            Permission::firstOrCreate(['name' => $perm]);
        }

        // ── Roles ────────────────────────────────────────────

        // ADMIN: tudo
        $admin = Role::firstOrCreate(['name' => 'admin']);
        $admin->syncPermissions(Permission::all());

        // PROFESSOR
        $professor = Role::firstOrCreate(['name' => 'professor']);
        $professor->syncPermissions([
            'ocorrencias.view_own',
            'ocorrencias.create',
            'maquinas.view',
            'dashboard.view',
        ]);

        // TÉCNICO
        $tecnico = Role::firstOrCreate(['name' => 'tecnico']);
        $tecnico->syncPermissions([
            'ocorrencias.view',
            'ocorrencias.assumir',
            'inspecoes.view',
            'inspecoes.create',
            'inspecoes.executar',
            'corretivas.view',
            'corretivas.create',
            'corretivas.executar',
            'preventivas.view',
            'preventivas.executar',
            'solicitacoes_pecas.view',
            'solicitacoes_pecas.create',
            'orcamentos.view',
            'maquinas.view',
            'maquinas.map',
            'dashboard.view',
        ]);
    }
}