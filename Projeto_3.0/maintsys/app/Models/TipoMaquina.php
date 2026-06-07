<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TipoMaquina extends Model
{
    use HasFactory;

    protected $table = 'tipos_maquina';

    protected $fillable = [
        'nome',
        'descricao',
        'ativo',
    ];

    protected $casts = [
        'ativo' => 'boolean',
    ];

    public function maquinas(): HasMany
    {
        return $this->hasMany(Maquina::class, 'tipo_maquina_id');
    }

    public function checklistModelos(): HasMany
    {
        return $this->hasMany(ChecklistModelo::class, 'tipo_maquina_id');
    }

    public function scopeAtivos($query)
    {
        return $query->where('ativo', true);
    }
}
