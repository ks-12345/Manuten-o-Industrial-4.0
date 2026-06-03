<?php

namespace App\Models;

use App\Enums\TipoResposta;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ChecklistPergunta extends Model
{
    use HasFactory;

    protected $table = 'checklist_perguntas';

    protected $fillable = [
        'checklist_modelo_id',
        'pergunta',
        'tipo_resposta',
        'obrigatoria',
        'ordem',
        'ajuda',
    ];

    protected $casts = [
        'tipo_resposta' => TipoResposta::class,
        'obrigatoria'   => 'boolean',
        'ordem'         => 'integer',
    ];

    public function modelo(): BelongsTo
    {
        return $this->belongsTo(ChecklistModelo::class, 'checklist_modelo_id');
    }

    public function respostas(): HasMany
    {
        return $this->hasMany(ChecklistResposta::class, 'checklist_pergunta_id');
    }
}