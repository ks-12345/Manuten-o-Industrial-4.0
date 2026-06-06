<?php

use Illuminate\Support\Facades\Route;

Route::redirect('/', '/painel');

Route::redirect('/login', '/painel/login')->name('login');
