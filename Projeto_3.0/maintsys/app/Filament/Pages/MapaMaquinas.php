<?php

namespace App\Filament\Pages;

use App\Models\Maquina;
use App\Models\Setor;
use App\Services\MapaMaquinasService;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Pages\Page;
use Livewire\Attributes\On;
use Illuminate\Support\Facades\Auth;

class MapaMaquinas extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon  = 'heroicon-o-map';
    protected static ?string $navigationGroup = 'Operações';
    protected static ?string $navigationLabel = 'Mapa de Máquinas';
    protected static ?string $title           = 'Mapa de Máquinas';
    protected static ?int    $navigationSort  = 10;
    protected static string  $view            = 'filament.pages.mapa-maquinas';

    public ?int    $setorSelecionado = null;
    public array   $maquinas         = [];
    public array   $resumoStatus     = [];
    public ?array  $maquinaSelecionada = null;

    public static function canAccess(): bool
    {
        return Auth::user()?->hasPermissionTo('maquinas.map') ?? false;
    }

    public function mount(): void
    {
        $this->setorSelecionado = request('setor');
        $this->carregarMaquinas();
    }

    public function carregarMaquinas(): void
    {
        $service = app(MapaMaquinasService::class);
        $this->maquinas    = $service->getMaquinasParaMapa($this->setorSelecionado);
        $this->resumoStatus = $service->resumoStatus($this->setorSelecionado);
    }

    public function selecionarSetor(?int $setorId): void
    {
        $this->setorSelecionado = $setorId;
        $this->carregarMaquinas();
    }

    public function selecionarMaquina(int $maquinaId): void
    {
        $this->maquinaSelecionada = collect($this->maquinas)->firstWhere('id', $maquinaId);
    }

    #[On('maquina-movida')]
    public function maquinaMovida(int $maquinaId, float $x, float $y): void
    {
        $user = Auth::user();

if (! $user?->hasRole('admin')) {
    return;
}

        app(MapaMaquinasService::class)->atualizarPosicao($maquinaId, $x, $y);
        $this->carregarMaquinas();
    }

    public function getSetores(): \Illuminate\Database\Eloquent\Collection
    {
        return Setor::ativos()->get(['id', 'nome', 'codigo']);
    }
}