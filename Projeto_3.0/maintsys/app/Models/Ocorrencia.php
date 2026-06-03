<?php

namespace App\Models;

use App\Enums\PrioridadeOcorrencia;
use App\Enums\StatusOcorrencia;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class Ocorrencia extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'codigo',
        'maquina_id',
        'professor_id',
        'tecnico_id',
        'titulo',
        'descricao',
        'prioridade',
        'status',
        'observacoes_internas',
        'assumida_em',
        'finalizada_em',
    ];

    protected $casts = [
        'prioridade'    => PrioridadeOcorrencia::class,
        'status'        => StatusOcorrencia::class,
        'assumida_em'   => 'datetime',
        'finalizada_em' => 'datetime',
    ];

    // ──────────────────────── Booted ────────────────────────

    protected static function booted(): void
    {
        static::creating(function (Ocorrencia $ocorrencia) {
            $ocorrencia->codigo = static::gerarCodigo();
        });
    }

    // ──────────────────────── Código ─────────────────────────

    public static function gerarCodigo(): string
    {
        $ano = now()->format('Y');
        $ultimo = static::whereYear('created_at', $ano)
                        ->lockForUpdate()
                        ->count();
        return sprintf('OC-%s-%04d', $ano, $ultimo + 1);
    }

    // ──────────────────────── Scopes ────────────────────────

    public function scopeAbertas($query)
    {
        return $query->where('status', StatusOcorrencia::Aberta);
    }

    public function scopeEmAndamento($query)
    {
        return $query->whereNotIn('status', [
            StatusOcorrencia::Finalizada->value,
            StatusOcorrencia::Cancelada->value,
        ]);
    }

    public function scopePorProfessor($query, int $userId)
    {
        return $query->where('professor_id', $userId);
    }

    public function scopePorTecnico($query, int $userId)
    {
        return $query->where('tecnico_id', $userId);
    }

    // ──────────────────────── Relationships ──────────────────

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function professor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'professor_id');
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }

    public function inspecao(): HasOne
    {
        return $this->hasOne(Inspecao::class, 'ocorrencia_id');
    }

    public function corretiva(): HasOne
    {
        return $this->hasOne(Corretiva::class, 'ocorrencia_id');
    }

    public function historicos()
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function podeTransicionarPara(StatusOcorrencia $novoStatus): bool
    {
        return in_array($novoStatus, $this->status->transicoesPermitidas());
    }

    public function estaFinalizada(): bool
    {
        return $this->status === StatusOcorrencia::Finalizada;
    }

    public function estaCancelada(): bool
    {
        return $this->status === StatusOcorrencia::Cancelada;
    }
}