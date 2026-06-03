<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Console\Scheduling\Schedule;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web(append: [
            \App\Http\Middleware\VerificarUsuarioTemporario::class,
        ]);
    })
    ->withSchedule(function (Schedule $schedule) {
        // Gerar preventivas diariamente à meia-noite
        $schedule->command('maintsys:gerar-preventivas')
            ->dailyAt('00:00')
            ->withoutOverlapping();

        // Bloquear usuários expirados a cada hora
        $schedule->command('maintsys:bloquear-usuarios-expirados')
            ->hourly();

        // Marcar preventivas atrasadas todo dia às 6h
        $schedule->command('maintsys:marcar-preventivas-atrasadas')
            ->dailyAt('06:00');
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })
    ->create();