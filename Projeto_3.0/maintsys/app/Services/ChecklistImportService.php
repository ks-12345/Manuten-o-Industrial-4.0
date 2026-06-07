<?php

namespace App\Services;

use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use RuntimeException;
use SplFileObject;
use Smalot\PdfParser\Parser;
use PhpOffice\PhpSpreadsheet\IOFactory;

class ChecklistImportService
{
    public function perguntasFromStorage(string $path, ?string $disk = null): array
    {
        $absolutePath = $disk
            ? Storage::disk($disk)->path($path)
            : Storage::path($path);

        return $this->perguntasFromFile($absolutePath);
    }

    public function perguntasFromFile(string $path): array
    {
        $extension = Str::lower(pathinfo($path, PATHINFO_EXTENSION));

        $text = match ($extension) {
            'pdf' => $this->parsePdf($path),
            'xlsx', 'xls' => $this->parseExcel($path),
            'csv', 'txt' => $this->parseTextFile($path),
            default => throw new RuntimeException('Formato de arquivo não suportado para importação de checklist.'),
        };

        return $this->textToPerguntas($text);
    }

    public function textToPerguntas(string $text): array
    {
        return Collection::make(preg_split('/\R+/', $text) ?: [])
            ->map(fn (string $line) => trim($line))
            ->filter()
            ->map(fn (string $line) => preg_replace('/^\s*(?:[-*•]|\d+[.)-])\s*/u', '', $line))
            ->map(fn (?string $line) => trim((string) $line))
            ->filter(fn (string $line) => mb_strlen($line) >= 5)
            ->unique()
            ->values()
            ->all();
    }

    private function parsePdf(string $path): string
    {
        if (! class_exists(Parser::class)) {
            throw new RuntimeException('Para importar PDF, instale o pacote smalot/pdfparser.');
        }

        return (new Parser())->parseFile($path)->getText();
    }

    private function parseExcel(string $path): string
    {
        if (class_exists(IOFactory::class)) {
            $spreadsheet = IOFactory::load($path);
            $lines = [];

            foreach ($spreadsheet->getAllSheets() as $sheet) {
                foreach ($sheet->toArray(null, true, true, true) as $row) {
                    $value = collect($row)
                        ->filter(fn ($cell) => filled($cell))
                        ->first();

                    if (filled($value)) {
                        $lines[] = (string) $value;
                    }
                }
            }

            return implode(PHP_EOL, $lines);
        }

        return $this->parseTextFile($path);
    }

    private function parseTextFile(string $path): string
    {
        $file = new SplFileObject($path);
        $lines = [];

        while (! $file->eof()) {
            $lines[] = (string) $file->fgets();
        }

        return implode('', $lines);
    }
}
