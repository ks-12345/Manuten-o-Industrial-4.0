<?php

namespace App\Models;

use App\Enums\TipoChecklist;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ChecklistModelo extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'checklist_modelos';

    protected $fillable = [
        'nome',
        'descricao',
        'tipo',
        'maquina_id',
        'ativo',
    ];

    protected $casts = [
        'tipo'  => TipoChecklist::class,
        'ativo' => 'boolean',
    ];

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function perguntas(): HasMany
    {
        return $this->hasMany(ChecklistPergunta::class, 'checklist_modelo_id')
                    ->orderBy('ordem');
    }

    public function scopeAtivos($query)
    {
        return $query->where('ativo', true);
    }

    public function scopePorTipo($query, TipoChecklist $tipo)
    {
        return $query->where('tipo', $tipo);
    }
}