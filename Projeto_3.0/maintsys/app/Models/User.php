<?php

namespace App\Models;

use App\Enums\StatusMaquina;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasRoles, SoftDeletes;

    protected $fillable = [
        'name',
        'email',
        'password',
        'is_temporary',
        'data_expiracao',
        'ativo',
        'avatar',
        'criado_por_id',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'data_expiracao'    => 'datetime',
            'password'          => 'hashed',
            'is_temporary'      => 'boolean',
            'ativo'             => 'boolean',
        ];
    }

    // ──────────────────────── Scopes ────────────────────────

    public function scopeAtivos($query)
    {
        return $query->where('ativo', true);
    }

    public function scopeTemporarios($query)
    {
        return $query->where('is_temporary', true);
    }

    public function scopeExpirados($query)
    {
        return $query->where('is_temporary', true)
                     ->where('data_expiracao', '<', now());
    }

    // ──────────────────────── Helpers ────────────────────────

    public function isExpired(): bool
    {
        return $this->is_temporary
            && $this->data_expiracao !== null
            && $this->data_expiracao->isPast();
    }

    public function isAdmin(): bool
    {
        return $this->hasRole('admin');
    }

    public function isProfessor(): bool
    {
        return $this->hasRole('professor');
    }

    public function isTecnico(): bool
    {
        return $this->hasRole('tecnico');
    }

    // ──────────────────────── Relationships ──────────────────

    public function criador()
    {
        return $this->belongsTo(User::class, 'criado_por_id');
    }

    public function usuariosCriados(): HasMany
    {
        return $this->hasMany(User::class, 'criado_por_id');
    }

    public function setoresResponsavel(): HasMany
    {
        return $this->hasMany(Setor::class, 'responsavel_id');
    }

    /** Ocorrências que o usuário criou (como Professor) */
    public function ocorrenciasCriadas(): HasMany
    {
        return $this->hasMany(Ocorrencia::class, 'professor_id');
    }

    /** Ocorrências atribuídas ao usuário (como Técnico) */
    public function ocorrenciasAtribuidas(): HasMany
    {
        return $this->hasMany(Ocorrencia::class, 'tecnico_id');
    }

    public function inspecoes(): HasMany
    {
        return $this->hasMany(Inspecao::class, 'tecnico_id');
    }

    public function corretivas(): HasMany
    {
        return $this->hasMany(Corretiva::class, 'tecnico_id');
    }

    public function preventivas(): HasMany
    {
        return $this->hasMany(Preventiva::class, 'tecnico_id');
    }

    public function historicos()
    {
        return $this->hasMany(Historico::class, 'user_id');
    }
}