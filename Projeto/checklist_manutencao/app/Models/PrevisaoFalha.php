<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PrevisaoFalha extends Model {
    protected $table = 'previsoes_falhas';
    protected $fillable = ['maquina_id', 'nivel_risco', 'descricao', 'data_analise'];

    public function maquina() { return $this->belongsTo(Maquina::class); }
}
