<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class SetorFactory extends Factory
{
    public function definition(): array
    {
        $setores = ['Produção', 'Manutenção', 'Almoxarifado', 'Laboratório', 'Usinagem', 'Solda', 'Pintura'];

        return [
            'nome'           => $this->faker->unique()->randomElement($setores) . ' ' . $this->faker->numerify('##'),
            'codigo'         => strtoupper($this->faker->unique()->bothify('SET-###')),
            'responsavel_id' => User::factory(),
            'localizacao'    => 'Bloco ' . $this->faker->randomLetter() . ', Sala ' . $this->faker->numberBetween(1, 20),
            'ativo'          => true,
            'descricao'      => $this->faker->sentence(),
        ];
    }
}