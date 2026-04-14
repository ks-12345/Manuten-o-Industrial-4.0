<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

// app/Models/Maquina.php
class Maquina extends Model {
    protected $table = 'maquinas';
    protected $fillable = ['nome', 'codigo', 'localizacao_id', 'status', 'data_aquisicao', 'descricao'];

    public function localizacao() {
        return $this->belongsTo(Localizacao::class, 'localizacao_id');
    }
    public function inspecoes() {
        return $this->hasMany(Inspecao::class, 'maquina_id');
    }
    public function manutencoesPreventivas() {
        return $this->hasMany(ManutencaoPreventiva::class, 'maquina_id');
    }
    public function manutencoesCorretivas() {
        return $this->hasMany(ManutencaoCorretiva::class, 'maquina_id');
    }
    public function previsoesFalhas() {
        return $this->hasMany(PrevisaoFalha::class, 'maquina_id');
    }
    public function trocaPecas() {
        return $this->hasMany(TrocaPeca::class, 'maquina_id');
    }
}