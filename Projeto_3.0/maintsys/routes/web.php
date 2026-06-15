<?php

use Illuminate\Support\Facades\Route;
use App\Mail\AlertaManutencao;
use Illuminate\Support\Facades\Mail;

Route::redirect('/', '/painel');

Route::redirect('/login', '/painel/login')->name('login');


Route::get('/testar-email', function () {
    // Dispara o e-mail passando as 6 variáveis exatas que a classe precisa
    Mail::to('equipe.manutencao@empresa.com')->send(
        new AlertaManutencao(
            codigoOrdemServico: '2026-089',
            maquina: 'Esteira Transportadora TC-400',
            setor: 'Linha de Empacotamento 03',
            tecnico: 'Rodrigo Mendes',
            urgencia: 'Alta (Risco de Parada)',
            descricaoProblema: 'Ruído excessivo no rolamento do motor principal com princípio de superaquecimento. Necessário lubrificar ou substituir antes do próximo turno.'
        )
    );

    return 'E-mail com o novo design industrial disparado com sucesso! Verifique o Mailtrap.';
});