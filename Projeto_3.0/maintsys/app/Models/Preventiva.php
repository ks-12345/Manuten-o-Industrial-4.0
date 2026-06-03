<?php

namespace App\Models;

use App\Enums\PeriodicidadePreventiva;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Preventiva extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'maquina_id',
        'tecnico_id',
        'periodicidade',
        'data_prevista',
        'data_realizada',
        'observacoes',
        'status',
        'tempo_execucao',
        'custo',
    ];

    protected $casts = [
        'periodicidade'  => PeriodicidadePreventiva::class,
        'data_prevista'  => 'date',
        'data_realizada' => 'date',
        'custo'          => 'decimal:2',
    ];

    // ──────────────────────── Scopes ────────────────────────

    public function scopePendentes($query)
    {
        return $query->where('status', 'pendente');
    }

    public function scopeAtrasadas($query)
    {
        return $query->where('status', 'atrasada')
                     ->orWhere(fn($q) => $q->where('status', 'pendente')
                                           ->where('data_prevista', '<', now()->toDateString()));
    }

    // ──────────────────────── Relationships ──────────────────

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
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

    public function estaAtrasada(): bool
    {
        return $this->status === 'pendente'
            && $this->data_prevista->isPast();
    }

    public function diasAtraso(): int
    {
        if (!$this->estaAtrasada()) return 0;
        return (int) $this->data_prevista->diffInDays(now());
    }
}