<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ManutencaoCorretiva extends Model {
    protected $table = 'manutencoes_corretivas';
    protected $fillable = ['maquina_id', 'tecnico_id', 'tipo_falha', 'gravidade', 'status', 'descricao', 'data_abertura', 'data_fechamento'];

    public function maquina() { return $this->belongsTo(Maquina::class); }
    public function tecnico() { return $this->belongsTo(Tecnico::class); }
}
