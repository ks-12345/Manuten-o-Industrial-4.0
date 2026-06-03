<?php

namespace Database\Seeders;

use App\Enums\PeriodicidadePreventiva;
use App\Enums\StatusMaquina;
use App\Models\Maquina;
use App\Models\Setor;
use Illuminate\Database\Seeder;

class MaquinaSeeder extends Seeder
{
    public function run(): void
    {
        $setorProducao  = Setor::where('codigo', 'PROD-01')->first();
        $setorUsinagem  = Setor::where('codigo', 'USIN-01')->first();
        $setorLab       = Setor::where('codigo', 'LAB-01')->first();

        $maquinas = [
            [
                'setor_id'                 => $setorProducao?->id ?? 1,
                'nome'                     => 'Torno CNC ROMI',
                'patrimonio'               => 'PAT-10001',
                'fabricante'               => 'ROMI',
                'modelo'                   => 'GL240M',
                'serie'                    => 'SN-20240001',
                'tensao'                   => '380V',
                'potencia'                 => '15kW',
                'status'                   => StatusMaquina::Operando->value,
                'periodicidade_preventiva' => PeriodicidadePreventiva::Mensal->value,
                'ultima_preventiva'        => now()->subDays(20),
                'posicao_x'               => 100,
                'posicao_y'               => 100,
            ],
            [
                'setor_id'                 => $setorProducao?->id ?? 1,
                'nome'                     => 'Fresadora Universal',
                'patrimonio'               => 'PAT-10002',
                'fabricante'               => 'Indústrias Romi',
                'modelo'                   => 'F550',
                'serie'                    => 'SN-20240002',
                'tensao'                   => '220V',
                'potencia'                 => '7.5kW',
                'status'                   => StatusMaquina::Atencao->value,
                'periodicidade_preventiva' => PeriodicidadePreventiva::Quinzenal->value,
                'ultima_preventiva'        => now()->subDays(18),
                'posicao_x'               => 300,
                'posicao_y'               => 100,
            ],
            [
                'setor_id'                 => $setorUsinagem?->id ?? 2,
                'nome'                     => 'Prensa Hidráulica',
                'patrimonio'               => 'PAT-10003',
                'fabricante'               => 'Schuler',
                'modelo'                   => 'PH-200T',
                'serie'                    => 'SN-20240003',
                'tensao'                   => '380V',
                'potencia'                 => '22kW',
                'status'                   => StatusMaquina::Quebrada->value,
                'periodicidade_preventiva' => PeriodicidadePreventiva::Trimestral->value,
                'ultima_preventiva'        => now()->subDays(95),
                'posicao_x'               => 150,
                'posicao_y'               => 200,
            ],
            [
                'setor_id'                 => $setorLab?->id ?? 3,
                'nome'                     => 'Compressor Atlas Copco',
                'patrimonio'               => 'PAT-10004',
                'fabricante'               => 'Atlas Copco',
                'modelo'                   => 'GA30',
                'serie'                    => 'SN-20240004',
                'tensao'                   => '380V',
                'potencia'                 => '30kW',
                'status'                   => StatusMaquina::Manutencao->value,
                'periodicidade_preventiva' => PeriodicidadePreventiva::Semestral->value,
                'ultima_preventiva'        => now()->subMonths(4),
                'posicao_x'               => 500,
                'posicao_y'               => 300,
            ],
        ];

        foreach ($maquinas as $dados) {
            Maquina::firstOrCreate(
                ['patrimonio' => $dados['patrimonio']],
                $dados
            );
        }
    }
}