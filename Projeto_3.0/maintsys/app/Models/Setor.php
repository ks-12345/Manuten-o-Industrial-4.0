<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Setor extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'setores';
    
    protected $fillable = [
        'nome',
        'codigo',
        'responsavel_id',
        'localizacao',
        'ativo',
        'descricao',
    ];

    protected $casts = [
        'ativo' => 'boolean',
    ];

    // ──────────────────────── Scopes ────────────────────────

    public function scopeAtivos($query)
    {
        return $query->where('ativo', true);
    }

    // ──────────────────────── Relationships ──────────────────

    public function responsavel(): BelongsTo
    {
        return $this->belongsTo(User::class, 'responsavel_id');
    }

    public function maquinas(): HasMany
    {
        return $this->hasMany(Maquina::class, 'setor_id');
    }

    public function maquinasAtivas(): HasMany
    {
        return $this->hasMany(Maquina::class, 'setor_id')
                    ->whereNull('deleted_at');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function totalMaquinas(): int
    {
        return $this->maquinas()->count();
    }

    public function maquinasComProblema(): int
    {
        return $this->maquinas()
                    ->whereIn('status', ['quebrada', 'atencao', 'aguardando_peca'])
                    ->count();
    }
}