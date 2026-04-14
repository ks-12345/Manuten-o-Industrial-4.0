<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tecnico extends Model {
    protected $table = 'tecnicos';
    protected $fillable = ['nome', 'email', 'tipo'];

    public function inspecoes() {
        return $this->hasMany(Inspecao::class, 'tecnico_id');
    }
    public function manutencoesCorretivas() {
        return $this->hasMany(ManutencaoCorretiva::class, 'tecnico_id');
    }
}