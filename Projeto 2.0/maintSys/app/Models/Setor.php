<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Setor extends Model
{
    use SoftDeletes;
protected $table = 'setores';
    protected $fillable = [
        'nome', 'codigo', 'descricao',
        'responsavel', 'localizacao', 'ativo',
    ];

    protected $casts = [
        'ativo' => 'boolean',
    ];

    public function maquinas(): HasMany
    {
        return $this->hasMany(Maquina::class);
    }

    public function ocorrencias(): HasMany
    {
        return $this->hasMany(Ocorrencia::class);
    }
}