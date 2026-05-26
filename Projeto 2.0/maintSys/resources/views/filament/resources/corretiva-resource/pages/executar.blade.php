<x-filament-panels::page>
    @livewire(\App\Livewire\Corretiva\ExecutarChecklistCorretiva::class, ['corretivaId' => (string) $record->getKey()])
</x-filament-panels::page>
