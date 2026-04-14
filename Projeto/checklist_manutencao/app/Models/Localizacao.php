<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

// app/Models/Localizacao.php
class Localizacao extends Model {
    protected $table = 'localizacoes';
    protected $fillable = ['nome', 'pos_x', 'pos_y'];

    public function maquinas() {
        return $this->hasMany(Maquina::class, 'localizacao_id');
    }
}