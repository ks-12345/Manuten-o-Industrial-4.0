<?php
namespace App\Models;

use App\Enums\StatusMaquina;
use App\Enums\PeriodicidadePreventiva;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Maquina extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'setor_id', 'nome', 'modelo', 'fabricante',
        'numero_serie', 'patrimonio', 'tensao', 'potencia',
        'data_aquisicao', 'data_instalacao', 'status',
        'foto', 'observacoes', 'ativo',
        'periodicidade_preventiva', 'ultima_preventiva',
        'proxima_preventiva', 'pos_x', 'pos_y',
    ];

    protected $casts = [
        'status'                   => StatusMaquina::class,
        'periodicidade_preventiva' => PeriodicidadePreventiva::class,
        'data_aquisicao'           => 'date',
        'data_instalacao'          => 'date',
        'ultima_preventiva'        => 'date',
        'proxima_preventiva'       => 'date',
        'ativo'                    => 'boolean',
    ];

    public function setor(): BelongsTo
    {
        return $this->belongsTo(Setor::class);
    }

    public function ocorrencias(): HasMany
    {
        return $this->hasMany(Ocorrencia::class);
    }

    public function inspecoes(): HasMany
    {
        return $this->hasMany(Inspecao::class);
    }

    public function corretivas(): HasMany
    {
        return $this->hasMany(Corretiva::class);
    }

    public function preventivas(): HasMany
    {
        return $this->hasMany(Preventiva::class);
    }

    public function checklistModelos(): HasMany
    {
        return $this->hasMany(ChecklistModelo::class);
    }

    public function pecasTrocadas(): HasMany
    {
        return $this->hasMany(PecaTrocada::class);
    }

    public function historicos(): HasMany
    {
        return $this->hasMany(Historico::class);
    }

    public function isPreventivaPróxima(): bool
    {
        if (!$this->proxima_preventiva) return false;
        return $this->proxima_preventiva->diffInDays(now()) <= 7
            && !$this->proxima_preventiva->isPast();
    }

    public function isPreventivaAtrasada(): bool
    {
        if (!$this->proxima_preventiva) return false;
        return $this->proxima_preventiva->isPast();
    }

    public function calcularProximaPreventiva(): void
    {
        if (!$this->periodicidade_preventiva) return;

        $base = $this->ultima_preventiva ?? now()->toDateString();
        $this->proxima_preventiva = \Carbon\Carbon::parse($base)
            ->addDays($this->periodicidade_preventiva->getDias());
        $this->saveQuietly();
    }
}