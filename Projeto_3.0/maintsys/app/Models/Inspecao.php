<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class Inspecao extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'inspecoes';
    
    protected $fillable = [
        'ocorrencia_id',
        'tecnico_id',
        'diagnostico',
        'observacoes',
        'inicio',
        'fim',
        'necessita_peca',
    ];

    protected $casts = [
        'inicio'        => 'datetime',
        'fim'           => 'datetime',
        'necessita_peca' => 'boolean',
    ];

    // ──────────────────────── Relationships ──────────────────

    public function ocorrencia(): BelongsTo
    {
        return $this->belongsTo(Ocorrencia::class);
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }

    public function solicitacaoPeca(): HasOne
    {
        return $this->hasOne(SolicitacaoPeca::class, 'inspecao_id');
    }

    public function checklistRespostas(): HasMany
    {
        return $this->morphMany(ChecklistResposta::class, 'checklistable');
    }

    public function historicos()
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function tempoDecorrido(): ?int
    {
        if (!$this->inicio) return null;
        $fim = $this->fim ?? now();
        return (int) $this->inicio->diffInMinutes($fim);
    }

    public function estaFinalizada(): bool
    {
        return $this->fim !== null;
    }

    public function podeFinalizar(): bool
    {
        return $this->inicio !== null && $this->fim === null;
    }
}