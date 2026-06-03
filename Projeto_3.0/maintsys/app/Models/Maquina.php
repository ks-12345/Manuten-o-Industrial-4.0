<?php

namespace App\Models;

use App\Enums\PeriodicidadePreventiva;
use App\Enums\StatusMaquina;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;

class Maquina extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'setor_id',
        'nome',
        'patrimonio',
        'fabricante',
        'modelo',
        'serie',
        'tensao',
        'potencia',
        'foto',
        'status',
        'observacoes',
        'ultima_preventiva',
        'periodicidade_preventiva',
        'posicao_x',
        'posicao_y',
    ];

    protected $casts = [
        'status'                   => StatusMaquina::class,
        'periodicidade_preventiva' => PeriodicidadePreventiva::class,
        'ultima_preventiva'        => 'date',
        'posicao_x'                => 'float',
        'posicao_y'                => 'float',
    ];

    // ──────────────────────── Scopes ────────────────────────

    public function scopeOperando($query)
    {
        return $query->where('status', StatusMaquina::Operando);
    }

    public function scopeComProblema($query)
    {
        return $query->whereIn('status', [
            StatusMaquina::Atencao->value,
            StatusMaquina::Quebrada->value,
            StatusMaquina::AguardandoPeca->value,
        ]);
    }

    public function scopeEmManutencao($query)
    {
        return $query->where('status', StatusMaquina::Manutencao);
    }

    // ──────────────────────── Relationships ──────────────────

    public function setor(): BelongsTo
    {
        return $this->belongsTo(Setor::class);
    }

    public function ocorrencias(): HasMany
    {
        return $this->hasMany(Ocorrencia::class, 'maquina_id');
    }

    public function ocorrenciasAbertas(): HasMany
    {
        return $this->hasMany(Ocorrencia::class, 'maquina_id')
                    ->whereNotIn('status', ['finalizada', 'cancelada']);
    }

    public function corretivas(): HasMany
    {
        return $this->hasMany(Corretiva::class, 'maquina_id');
    }

    public function preventivas(): HasMany
    {
        return $this->hasMany(Preventiva::class, 'maquina_id');
    }

    public function solicitacoesPecas(): HasMany
    {
        return $this->hasMany(SolicitacaoPeca::class, 'maquina_id');
    }

    public function historicos()
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }

    // ──────────────────────── Helpers ────────────────────────

    public function getFotoUrlAttribute(): ?string
    {
        if (!$this->foto) {
            return null;
        }
        return Storage::disk('s3')->url($this->foto);
    }

    public function proximaPreventiva(): ?\Carbon\Carbon
    {
        if (!$this->ultima_preventiva || !$this->periodicidade_preventiva) {
            return null;
        }
        return $this->ultima_preventiva->addDays(
            $this->periodicidade_preventiva->diasIntervalo()
        );
    }

    public function preventivaNoPrazo(): bool
    {
        $proxima = $this->proximaPreventiva();
        if (!$proxima) return true;
        return $proxima->isFuture();
    }

    public function diasParaProximaPreventiva(): ?int
    {
        $proxima = $this->proximaPreventiva();
        if (!$proxima) return null;
        return (int) now()->diffInDays($proxima, false);
    }
}