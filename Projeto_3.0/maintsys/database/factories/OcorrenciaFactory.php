<?php

namespace Database\Factories;

use App\Enums\PrioridadeOcorrencia;
use App\Enums\StatusOcorrencia;
use App\Models\Maquina;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class OcorrenciaFactory extends Factory
{
    public function definition(): array
    {
        $titulos = [
            'Máquina parada sem motivo aparente',
            'Ruído excessivo no motor',
            'Vazamento de óleo hidráulico',
            'Erro de comunicação CNC',
            'Superaquecimento do painel elétrico',
            'Vibração anormal no eixo',
        ];

        return [
            'codigo'      => '', // gerado pelo Observer no creating
            'maquina_id'  => Maquina::factory(),
            'professor_id'=> User::factory(),
            'tecnico_id'  => null,
            'titulo'      => $this->faker->randomElement($titulos),
            'descricao'   => $this->faker->paragraph(),
            'prioridade'  => $this->faker->randomElement(PrioridadeOcorrencia::cases())->value,
            'status'      => StatusOcorrencia::Aberta->value,
        ];
    }
}