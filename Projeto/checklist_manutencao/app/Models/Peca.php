<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Peca extends Model {
    protected $table = 'pecas';
    protected $fillable = ['nome', 'descricao'];
    public function trocas() { return $this->hasMany(TrocaPeca::class, 'peca_id'); }
}
