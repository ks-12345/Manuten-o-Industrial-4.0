<x-filament-panels::page.simple>
    @if ($precisaEscolherPerfil)
        {{-- Tela de seleção de perfil --}}
        <div class="flex flex-col items-center gap-6 p-6">
            <div class="text-center">
                <x-filament::icon icon="heroicon-o-user-circle" class="mx-auto h-16 w-16 text-primary-500" />
                <h2 class="mt-4 text-2xl font-bold text-gray-800 dark:text-white">Entrar como...</h2>
                <p class="mt-1 text-sm text-gray-500">Você possui dois perfis. Selecione como deseja acessar o sistema.</p>
            </div>

            <div class="grid w-full max-w-sm grid-cols-2 gap-4">
                <button
                    wire:click="$set('perfilSelecionado', 'professor')"
                    class="flex flex-col items-center gap-2 rounded-xl border-2 p-6 transition-all
                           {{ $perfilSelecionado === 'professor' ? 'border-primary-500 bg-primary-50 dark:bg-primary-900/20' : 'border-gray-200 hover:border-primary-300 dark:border-gray-700' }}"
                >
                    <x-filament::icon icon="heroicon-o-academic-cap" class="h-10 w-10 text-primary-500" />
                    <span class="font-semibold text-gray-800 dark:text-white">Professor</span>
                </button>

                <button
                    wire:click="$set('perfilSelecionado', 'tecnico')"
                    class="flex flex-col items-center gap-2 rounded-xl border-2 p-6 transition-all
                           {{ $perfilSelecionado === 'tecnico' ? 'border-primary-500 bg-primary-50 dark:bg-primary-900/20' : 'border-gray-200 hover:border-primary-300 dark:border-gray-700' }}"
                >
                    <x-filament::icon icon="heroicon-o-wrench-screwdriver" class="h-10 w-10 text-primary-500" />
                    <span class="font-semibold text-gray-800 dark:text-white">Técnico</span>
                </button>
            </div>

            <x-filament::button
                wire:click="confirmarPerfil"
                :disabled="!$perfilSelecionado"
                class="w-full"
            >
                Confirmar e Entrar
            </x-filament::button>
        </div>
    @else
        {{-- Login padrão --}}
        <x-filament-panels::form wire:submit="authenticate">
            {{ $this->form }}

            <x-filament-panels::form.actions
                :actions="$this->getCachedFormActions()"
                :full-width="$this->hasFullWidthFormActions()"
            />
        </x-filament-panels::form>
    @endif
</x-filament-panels::page.simple>