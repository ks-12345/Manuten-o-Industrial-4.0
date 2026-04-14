<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Inspecao extends Model {
    protected $table = 'inspecoes';
    protected $fillable = ['maquina_id', 'tecnico_id', 'data_inspecao', 'observacoes', 'status'];

    public function maquina() { return $this->belongsTo(Maquina::class); }
    public function tecnico() { return $this->belongsTo(Tecnico::class); }
    public function itens() { return $this->hasMany(InspecaoItem::class, 'inspecao_id'); }
}