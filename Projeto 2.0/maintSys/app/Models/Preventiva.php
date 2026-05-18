<?php
namespace App\Models;

use App\Enums\StatusPreventiva;
use App\Enums\PeriodicidadePreventiva;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Preventiva extends Model
{
    protected $fillable = [
        'maquina_id', 'tecnico_id', 'data_prevista',
        'data_realizada', 'status', 'periodicidade',
        'observacoes', 'resumo', 'tempo_realizado_minutos',
    ];

    protected $casts = [
        'status'          => StatusPreventiva::class,
        'periodicidade'   => PeriodicidadePreventiva::class,
        'data_prevista'   => 'date',
        'data_realizada'  => 'date',
    ];

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
}