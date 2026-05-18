<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class ChecklistResposta extends Model
{
    protected $fillable = [
        'checklist_pergunta_id', 'tecnico_id',
        'checklistavel_id', 'checklistavel_type',
        'resposta', 'observacao', 'foto', 'conforme',
    ];

    protected $casts = [
        'conforme' => 'boolean',
    ];

    public function pergunta(): BelongsTo
    {
        return $this->belongsTo(ChecklistPergunta::class, 'checklist_pergunta_id');
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }

    public function checklistavel(): MorphTo
    {
        return $this->morphTo();
    }
}