<x-filament-panels::page>
    @livewire(\App\Livewire\Inspecao\ExecutarChecklistInspecao::class, ['inspecaoId' => (string) $record->getKey()])
</x-filament-panels::page>
