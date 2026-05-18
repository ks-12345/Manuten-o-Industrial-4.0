<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Historico extends Model
{
    protected $fillable = [
        'maquina_id', 'user_id', 'historiavel_id',
        'historiavel_type', 'tipo', 'acao',
        'descricao', 'dados_anteriores', 'dados_novos',
    ];

    protected $casts = [
        'dados_anteriores' => 'array',
        'dados_novos'      => 'array',
    ];

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function historiavel(): MorphTo
    {
        return $this->morphTo();
    }
}