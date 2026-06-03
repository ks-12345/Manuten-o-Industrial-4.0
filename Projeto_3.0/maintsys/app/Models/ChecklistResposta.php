<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Storage;

class ChecklistResposta extends Model
{
    use HasFactory;

    protected $table = 'checklist_respostas';

    protected $fillable = [
        'checklist_pergunta_id',
        'checklistable_type',
        'checklistable_id',
        'resposta',
        'observacao',
        'foto',
    ];

    // ──────────────────────── Relationships ──────────────────

    public function pergunta(): BelongsTo
    {
        return $this->belongsTo(ChecklistPergunta::class, 'checklist_pergunta_id');
    }

    /** Polimórfico: Inspecao | Corretiva | Preventiva */
    public function checklistable()
    {
        return $this->morphTo();
    }

    // ──────────────────────── Helpers ────────────────────────

    public function getFotoUrlAttribute(): ?string
    {
        if (!$this->foto) return null;
        return Storage::disk('s3')->url($this->foto);
    }

    public function respostaFormatada(): string
    {
        return match($this->pergunta?->tipo_resposta) {
            \App\Enums\TipoResposta::SimNao,
            \App\Enums\TipoResposta::OkProblema => strtoupper($this->resposta ?? '-'),
            default => $this->resposta ?? '-',
        };
    }
}