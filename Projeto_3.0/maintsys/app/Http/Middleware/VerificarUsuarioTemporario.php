<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class VerificarUsuarioTemporario
{
    public function handle(Request $request, Closure $next): Response
    {
        if (Auth::check() && Auth::user()->isExpired()) {
            Auth::logout();
            $request->session()->invalidate();
            $request->session()->regenerateToken();

            return redirect()->route('login')
                ->withErrors(['email' => 'Seu acesso temporário expirou. Contate o administrador.']);
        }

        if (Auth::check() && !Auth::user()->ativo) {
            Auth::logout();
            return redirect()->route('login')
                ->withErrors(['email' => 'Sua conta está desativada.']);
        }

        return $next($request);
    }
}