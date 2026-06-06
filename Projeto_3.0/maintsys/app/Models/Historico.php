<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Auth;

class Historico extends Model
{
    public $timestamps = false; // Usamos apenas created_at

    const UPDATED_AT = null;

    protected $fillable = [
        'historiavel_type',
        'historiavel_id',
        'user_id',
        'acao',
        'descricao',
        'dados_anteriores',
        'dados_novos',
        'ip',
        'created_at',
    ];

    protected $casts = [
        'dados_anteriores' => 'array',
        'dados_novos'      => 'array',
        'created_at'       => 'datetime',
    ];

    // ──────────────────── Acoes constantes ──────────────────

    const ACAO_OCORRENCIA_CRIADA       = 'ocorrencia.criada';
    const ACAO_OCORRENCIA_ASSUMIDA     = 'ocorrencia.assumida';
    const ACAO_OCORRENCIA_FINALIZADA   = 'ocorrencia.finalizada';
    const ACAO_OCORRENCIA_CANCELADA    = 'ocorrencia.cancelada';
    const ACAO_INSPECAO_INICIADA       = 'inspecao.iniciada';
    const ACAO_INSPECAO_FINALIZADA     = 'inspecao.finalizada';
    const ACAO_SOLICITACAO_PECA        = 'solicitacao.peca.criada';
    const ACAO_ORCAMENTO_APROVADO      = 'orcamento.aprovado';
    const ACAO_PECA_RECEBIDA           = 'peca.recebida';
    const ACAO_CORRETIVA_INICIADA      = 'corretiva.iniciada';
    const ACAO_CORRETIVA_FINALIZADA    = 'corretiva.finalizada';
    const ACAO_PREVENTIVA_REALIZADA    = 'preventiva.realizada';
    const ACAO_STATUS_ALTERADO         = 'status.alterado';

    // ──────────────────────── Relationships ──────────────────

    public function historiavel()
    {
        return $this->morphTo();
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    // ──────────────────────── Factory Method ─────────────────

    public static function registrar(
        Model $model,
        string $acao,
        string $descricao,
        ?User $user = null,
        array $dadosAnteriores = [],
        array $dadosNovos = []
    ): self {
        return static::create([
            'historiavel_type' => get_class($model),
            'historiavel_id'   => $model->getKey(),
            'user_id'          => $user?->id ?? Auth::id(),
            'acao'             => $acao,
            'descricao'        => $descricao,
            'dados_anteriores' => $dadosAnteriores,
            'dados_novos'      => $dadosNovos,
            'ip'               => request()->ip(),
            'created_at'       => now(),
        ]);
    }
}