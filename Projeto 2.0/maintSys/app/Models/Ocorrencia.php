<?php
namespace App\Models;

use App\Enums\StatusOcorrencia;
use App\Enums\PrioridadeOcorrencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Ocorrencia extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'codigo', 'maquina_id', 'setor_id', 'aberto_por',
        'tecnico_id', 'titulo', 'descricao', 'prioridade',
        'status', 'foto', 'assumido_em', 'finalizado_em',
        'observacoes_tecnico',
    ];

    protected $casts = [
        'status'        => StatusOcorrencia::class,
        'prioridade'    => PrioridadeOcorrencia::class,
        'assumido_em'   => 'datetime',
        'finalizado_em' => 'datetime',
    ];

    protected static function booted(): void
    {
        static::creating(function (Ocorrencia $o) {
            $o->codigo = 'OC-' . str_pad(
                Ocorrencia::withTrashed()->count() + 1,
                5, '0', STR_PAD_LEFT
            );
        });
    }

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function setor(): BelongsTo
    {
        return $this->belongsTo(Setor::class);
    }

    public function abertoPor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'aberto_por');
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }

    public function inspecao(): HasOne
    {
        return $this->hasOne(Inspecao::class);
    }

    public function corretiva(): HasOne
    {
        return $this->hasOne(Corretiva::class);
    }

    public function historicos(): MorphMany
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }
}