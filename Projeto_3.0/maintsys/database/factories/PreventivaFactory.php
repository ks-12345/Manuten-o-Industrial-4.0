<?php

namespace Database\Factories;

use App\Enums\PeriodicidadePreventiva;
use App\Models\Maquina;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class PreventivaFactory extends Factory
{
    public function definition(): array
    {
        $periodicidade = $this->faker->randomElement(PeriodicidadePreventiva::cases());

        return [
            'maquina_id'    => Maquina::factory(),
            'tecnico_id'    => null,
            'periodicidade' => $periodicidade->value,
            'data_prevista' => $this->faker->dateTimeBetween('now', '+3 months'),
            'data_realizada'=> null,
            'status'        => 'pendente',
            'custo'         => 0,
        ];
    }

    public function realizada(): static
    {
        return $this->state(function (array $attributes) {
            return [
                'data_realizada' => $this->faker->dateTimeBetween('-1 month', 'now'),
                'status'         => 'realizada',
                'tempo_execucao' => $this->faker->numberBetween(30, 240),
                'custo'          => $this->faker->randomFloat(2, 50, 500),
            ];
        });
    }
}