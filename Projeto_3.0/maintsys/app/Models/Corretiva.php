<?php

namespace App\Models;

use App\Enums\TipoCorretiva;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Corretiva extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'maquina_id',
        'ocorrencia_id',
        'tecnico_id',
        'tipo',
        'problema',
        'solucao',
        'resumo',
        'tempo_reparo',
        'custo_pecas',
        'custo_mao_obra',
        'status',
        'inicio',
        'fim',
    ];

    protected $casts = [
        'tipo'          => TipoCorretiva::class,
        'custo_pecas'   => 'decimal:2',
        'custo_mao_obra'=> 'decimal:2',
        'inicio'        => 'datetime',
        'fim'           => 'datetime',
    ];

    // ──────────────────────── Scopes ────────────────────────

    public function scopeEmAndamento($query)
    {
        return $query->where('status', 'em_andamento');
    }

    public function scopeFinalizadas($query)
    {
        return $query->where('status', 'finalizada');
    }

    // ──────────────────────── Relationships ──────────────────

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function ocorrencia(): BelongsTo
    {
        return $this->belongsTo(Ocorrencia::class);
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }

    public function checklistRespostas()
    {
        return $this->morphMany(ChecklistResposta::class, 'checklistable');
    }

    public function historicos()
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function custoTotal(): float
    {
        return (float) $this->custo_pecas + (float) $this->custo_mao_obra;
    }

    public function tempoDecorrido(): ?int
    {
        if (!$this->inicio) return null;
        $fim = $this->fim ?? now();
        return (int) $this->inicio->diffInMinutes($fim);
    }

    public function estaFinalizada(): bool
    {
        return $this->status === 'finalizada';
    }
}