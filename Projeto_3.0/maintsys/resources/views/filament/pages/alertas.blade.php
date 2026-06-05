<x-filament-widgets::widget>
    <x-filament::section>
        <x-slot name="heading">🚨 Alertas Críticos</x-slot>

        @php $alertas = $this->getAlertas(); @endphp

        @if(empty($alertas))
            <div class="flex items-center gap-3 text-green-600 dark:text-green-400">
                <x-filament::icon icon="heroicon-o-check-circle" class="w-6 h-6"/>
                <span class="font-medium">Nenhum alerta crítico no momento. ✅</span>
            </div>
        @else
            <div class="space-y-3">
                @foreach($alertas as $alerta)
                    <a href="{{ $alerta['link'] }}"
                       class="flex items-start gap-3 p-3 rounded-lg border transition-colors
                              {{ $alerta['tipo'] === 'danger'
                                  ? 'bg-red-50 border-red-200 hover:bg-red-100 dark:bg-red-900/20 dark:border-red-800'
                                  : 'bg-amber-50 border-amber-200 hover:bg-amber-100 dark:bg-amber-900/20 dark:border-amber-800' }}">
                        <x-filament::icon
                            :icon="$alerta['icon']"
                            class="w-5 h-5 mt-0.5 flex-shrink-0
                                   {{ $alerta['tipo'] === 'danger' ? 'text-red-500' : 'text-amber-500' }}"
                        />
                        <div>
                            <p class="font-semibold text-sm
                                      {{ $alerta['tipo'] === 'danger' ? 'text-red-800 dark:text-red-300' : 'text-amber-800 dark:text-amber-300' }}">
                                {{ $alerta['titulo'] }}
                            </p>
                            <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">{{ $alerta['detalhe'] }}</p>
                        </div>
                        <x-filament::icon icon="heroicon-o-arrow-right" class="w-4 h-4 ml-auto text-gray-400"/>
                    </a>
                @endforeach
            </div>
        @endif
    </x-filament::section>
</x-filament-widgets::widget>