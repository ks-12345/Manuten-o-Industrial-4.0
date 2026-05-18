<?php
namespace App\Models;

use App\Enums\StatusInspecao;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Inspecao extends Model
{
    protected $fillable = [
        'ocorrencia_id', 'maquina_id', 'tecnico_id',
        'diagnostico', 'observacoes', 'outro_problema',
        'descricao_outro_problema', 'status',
        'iniciado_em', 'finalizado_em',
    ];

    protected $casts = [
        'status'        => StatusInspecao::class,
        'outro_problema' => 'boolean',
        'iniciado_em'   => 'datetime',
        'finalizado_em' => 'datetime',
    ];

    public function ocorrencia(): BelongsTo
    {
        return $this->belongsTo(Ocorrencia::class);
    }

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
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