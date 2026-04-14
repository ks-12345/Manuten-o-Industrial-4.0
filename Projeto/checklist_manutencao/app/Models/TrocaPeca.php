<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrocaPeca extends Model {
    protected $table = 'troca_pecas';
    protected $fillable = ['maquina_id', 'peca_id', 'data_troca', 'observacoes'];
    public function maquina() { return $this->belongsTo(Maquina::class); }
    public function peca() { return $this->belongsTo(Peca::class); }
}
