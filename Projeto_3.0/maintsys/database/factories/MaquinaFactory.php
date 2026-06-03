<?php

namespace Database\Factories;

use App\Enums\PeriodicidadePreventiva;
use App\Enums\StatusMaquina;
use App\Models\Setor;
use Illuminate\Database\Eloquent\Factories\Factory;

class MaquinaFactory extends Factory
{
    public function definition(): array
    {
        $fabricantes = ['Siemens', 'ABB', 'WEG', 'Bosch', 'Rexroth', 'Festo', 'Danfoss'];
        $maquinas    = ['Torno CNC', 'Fresadora', 'Prensa Hidráulica', 'Compressor', 'Robô Soldador', 'Esteira'];

        return [
            'setor_id'                  => Setor::factory(),
            'nome'                      => $this->faker->randomElement($maquinas) . ' ' . $this->faker->numerify('###'),
            'patrimonio'                => $this->faker->unique()->numerify('PAT-#####'),
            'fabricante'                => $this->faker->randomElement($fabricantes),
            'modelo'                    => strtoupper($this->faker->bothify('??###')),
            'serie'                     => $this->faker->numerify('SN-#########'),
            'tensao'                    => $this->faker->randomElement(['110V', '220V', '380V', '440V']),
            'potencia'                  => $this->faker->randomElement(['2kW', '5kW', '10kW', '15kW', '30kW']),
            'foto'                      => null,
            'status'                    => $this->faker->randomElement(StatusMaquina::cases())->value,
            'observacoes'               => $this->faker->optional()->sentence(),
            'ultima_preventiva'         => $this->faker->optional()->dateTimeBetween('-1 year', 'now'),
            'periodicidade_preventiva'  => $this->faker->randomElement(PeriodicidadePreventiva::cases())->value,
            'posicao_x'                 => $this->faker->numberBetween(0, 900),
            'posicao_y'                 => $this->faker->numberBetween(0, 600),
        ];
    }

    public function operando(): static
    {
        return $this->state(['status' => StatusMaquina::Operando->value]);
    }

    public function quebrada(): static
    {
        return $this->state(['status' => StatusMaquina::Quebrada->value]);
    }
}