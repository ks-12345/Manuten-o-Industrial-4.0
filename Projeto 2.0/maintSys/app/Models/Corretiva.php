<?php
namespace App\Models;

use App\Enums\StatusCorretiva;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Corretiva extends Model
{
    protected $fillable = [
        'ocorrencia_id', 'inspecao_id', 'maquina_id', 'tecnico_id',
        'problema_identificado', 'solucao_aplicada', 'resumo_tecnico',
        'observacoes', 'foto_antes', 'foto_depois',
        'tempo_reparo_minutos', 'status', 'iniciado_em', 'finalizado_em',
    ];

    protected $casts = [
        'status'        => StatusCorretiva::class,
        'iniciado_em'   => 'datetime',
        'finalizado_em' => 'datetime',
    ];

    public function ocorrencia(): BelongsTo
    {
        return $this->belongsTo(Ocorrencia::class);
    }

    public function inspecao(): BelongsTo
    {
        return $this->belongsTo(Inspecao::class);
    }

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }

    public function pecasTrocadas(): HasMany
    {
        return $this->hasMany(PecaTrocada::class);
    }

    public function respostas(): MorphMany
    {
        return $this->morphMany(ChecklistResposta::class, 'checklistavel');
    }

    public function historicos(): MorphMany
    {
        return $this->morphMany(Historico::class, 'historiavel');
    }
}