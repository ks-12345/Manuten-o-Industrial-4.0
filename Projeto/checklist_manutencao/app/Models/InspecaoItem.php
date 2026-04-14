<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InspecaoItem extends Model {
    protected $table = 'inspecao_itens';
    protected $fillable = ['inspecao_id', 'item', 'status'];

    public function inspecao() { return $this->belongsTo(Inspecao::class); }
}
