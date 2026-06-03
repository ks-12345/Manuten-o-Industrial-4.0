<?php

namespace App\Models;

use App\Enums\StatusSolicitacaoPeca;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class SolicitacaoPeca extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'solicitacoes_pecas';

    protected $fillable = [
        'inspecao_id',
        'maquina_id',
        'nome_peca',
        'quantidade',
        'descricao',
        'referencia',
        'status',
        'valor_total_aprovado',
        'peca_recebida_em',
    ];

    protected $casts = [
        'status'              => StatusSolicitacaoPeca::class,
        'peca_recebida_em'    => 'datetime',
        'valor_total_aprovado'=> 'decimal:2',
    ];

    // ──────────────────────── Relationships ──────────────────

    public function inspecao(): BelongsTo
    {
        return $this->belongsTo(Inspecao::class);
    }

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function orcamentos(): HasMany
    {
        return $this->hasMany(Orcamento::class, 'solicitacao_peca_id');
    }

    public function orcamentoAprovado(): HasMany
    {
        return $this->hasMany(Orcamento::class, 'solicitacao_peca_id')
                    ->where('aprovado', true);
    }

    public function historicos()
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function totalOrcamentos(): int
    {
        return $this->orcamentos()->count();
    }

    public function podeAdicionarOrcamento(): bool
    {
        return $this->totalOrcamentos() < 3
            && !in_array($this->status->value, ['aprovado', 'aguardando_peca', 'peca_recebida', 'finalizado']);
    }

    public function menorOrcamento(): ?Orcamento
    {
        return $this->orcamentos()->orderBy('valor')->first();
    }
}