<?php
namespace App\Models;

use App\Enums\TipoChecklist;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ChecklistModelo extends Model
{
    protected $fillable = [
        'maquina_id', 'tipo', 'nome', 'descricao', 'ativo',
    ];

    protected $casts = [
        'tipo'  => TipoChecklist::class,
        'ativo' => 'boolean',
    ];

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function perguntas(): HasMany
    {
        return $this->hasMany(ChecklistPergunta::class)->orderBy('ordem');
    }
}