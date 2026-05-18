<?php
namespace App\Services;

use App\Models\Historico;
use Illuminate\Database\Eloquent\Model;

class HistoricoService
{
    public function registrar(
        int    $maquinaId,
        Model  $modelo,
        string $tipo,
        string $acao,
        string $descricao,
        array  $dadosAnteriores = [],
        array  $dadosNovos = []
    ): Historico {
        return Historico::create([
            'maquina_id'       => $maquinaId,
            'user_id'          => auth()->id(),
            'historiavel_id'   => $modelo->id,
            'historiavel_type'  => $modelo::class,
            'tipo'             => $tipo,
            'acao'             => $acao,
            'descricao'        => $descricao,
            'dados_anteriores' => $dadosAnteriores ?: null,
            'dados_novos'      => $dadosNovos ?: null,
        ]);
    }
}