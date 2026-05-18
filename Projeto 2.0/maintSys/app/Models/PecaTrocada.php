<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PecaTrocada extends Model
{
    protected $fillable = [
        'corretiva_id', 'maquina_id', 'tecnico_id',
        'nome_peca', 'codigo_peca', 'quantidade',
        'motivo_troca', 'observacoes', 'data_troca',
    ];

    protected $casts = [
        'data_troca' => 'date',
    ];

    public function corretiva(): BelongsTo
    {
        return $this->belongsTo(Corretiva::class);
    }

    public function maquina(): BelongsTo
    {
        return $this->belongsTo(Maquina::class);
    }

    public function tecnico(): BelongsTo
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }
}