<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ManutencaoPreventiva extends Model {
    protected $table = 'manutencoes_preventivas';
    protected $fillable = ['maquina_id', 'data_ultima', 'data_proxima', 'status'];

    public function maquina() { return $this->belongsTo(Maquina::class); }
}
