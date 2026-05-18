<?php
namespace App\Models;

use App\Enums\TipoResposta;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ChecklistPergunta extends Model
{
    protected $fillable = [
        'checklist_modelo_id', 'pergunta', 'tipo_resposta',
        'obrigatorio', 'ordem', 'ajuda', 'ativo',
    ];

    protected $casts = [
        'tipo_resposta' => TipoResposta::class,
        'obrigatorio'   => 'boolean',
        'ativo'         => 'boolean',
    ];

    public function modelo(): BelongsTo
    {
        return $this->belongsTo(ChecklistModelo::class, 'checklist_modelo_id');
    }

    public function respostas(): HasMany
    {
        return $this->hasMany(ChecklistResposta::class);
    }
}