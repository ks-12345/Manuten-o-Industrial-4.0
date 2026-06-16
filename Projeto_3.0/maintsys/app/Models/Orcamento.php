<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;
use App\Enums\StatusSolicitacaoPeca;

class Orcamento extends Model
{
    use HasFactory, SoftDeletes;

    // status: 'pendente' | 'aprovado' | 'negado'

    protected $fillable = [
        'solicitacao_peca_id',
        'empresa',
        'contato',
        'valor',
        'prazo_entrega',
        'observacoes',
        'status',           // novo campo
        'aprovado',
        'aprovado_por_id',
        'aprovado_em',
        'arquivo',
    ];

    protected $casts = [
        'valor'       => 'decimal:2',
        'aprovado'    => 'boolean',
        'aprovado_em' => 'datetime',
    ];

    // ──────────────────────── Relationships ──────────────────

    public function solicitacaoPeca(): BelongsTo
    {
        return $this->belongsTo(SolicitacaoPeca::class, 'solicitacao_peca_id');
    }

    public function aprovadoPor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'aprovado_por_id');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function getArquivoUrlAttribute(): ?string
    {
        if (!$this->arquivo) return null;
        return Storage::disk('s3')->url($this->arquivo);
    }

    public function aprovar(User $user): void
    {
        // Negar todos os outros orçamentos da mesma solicitação
        $this->solicitacaoPeca->orcamentos()
            ->where('id', '!=', $this->id)
            ->update([
                'aprovado'        => false,
                'status'          => 'negado',
                'aprovado_por_id' => null,
                'aprovado_em'     => null,
            ]);

        // Aprovar este
        $this->update([
            'aprovado'        => true,
            'status'          => 'aprovado',
            'aprovado_por_id' => $user->id,
            'aprovado_em'     => now(),
        ]);

        $this->solicitacaoPeca->update([
            'status'               => StatusSolicitacaoPeca::AguardandoPeca->value,
            'valor_total_aprovado' => $this->valor,
        ]);
    }

    public function negar(User $user): void
    {
        $this->update([
            'aprovado'        => false,
            'status'          => 'negado',
            'aprovado_por_id' => $user->id,
            'aprovado_em'     => now(),
        ]);
    }

    public function isPendente(): bool
    {
        return ($this->status ?? 'pendente') === 'pendente';
    }

    public function isAprovado(): bool
    {
        return $this->status === 'aprovado';
    }

    public function isNegado(): bool
    {
        return $this->status === 'negado';
    }
}