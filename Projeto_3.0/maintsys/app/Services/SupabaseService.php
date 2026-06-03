<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class SupabaseService
{
    protected string $url;
    protected ?string $anon;
    protected ?string $service;

    public function __construct()
    {
        $this->url = config('supabase.url');
        $this->anon = config('supabase.anon_key');
        $this->service = config('supabase.service_role_key');
    }

    protected function headers(bool $useService = false): array
    {
        $key = $useService ? $this->service : $this->anon;
        $token = $useService ? $this->service : $this->anon;

        return [
            'apikey' => $key ?: '',
            'Authorization' => $token ? 'Bearer ' . $token : '',
        ];
    }

    // Lista buckets de storage
    public function listBuckets()
    {
        $resp = Http::withHeaders($this->headers(true))
            ->get($this->url . '/storage/v1/bucket');

        return $resp->throw()->json();
    }

    // Faz upload de um arquivo para um bucket (multipart/form-data)
    public function uploadFile(string $bucket, string $path, string $contents, string $filename = null)
    {
        $endpoint = $this->url . '/storage/v1/object/' . $bucket . '/' . ltrim($path, '/');
        $filename = $filename ?: basename($path);

        $resp = Http::withHeaders([
            'apikey' => $this->service ?: '',
            'Authorization' => $this->service ? 'Bearer ' . $this->service : '',
        ])->attach('file', $contents, $filename)
            ->post($endpoint);

        return $resp->throw()->json();
    }

    // Autenticação: sign in com email/senha (retorna tokens)
    public function authSignIn(string $email, string $password)
    {
        $resp = Http::withHeaders([
            'apikey' => $this->anon ?: '',
            'Content-Type' => 'application/json',
        ])->post($this->url . '/auth/v1/token?grant_type=password', [
            'email' => $email,
            'password' => $password,
        ]);

        return $resp->throw()->json();
    }

    // Chamada simples para tabelas via REST (usa service role key)
    public function table(string $table, string $method = 'get', array $data = [], string $query = '')
    {
        $endpoint = $this->url . '/rest/v1/' . $table . ($query ? ('?' . ltrim($query, '?')) : '');
        $client = Http::withHeaders($this->headers(true));

        return match (strtolower($method)) {
            'get' => $client->get($endpoint)->throw()->json(),
            'post' => $client->post($endpoint, $data)->throw()->json(),
            'patch' => $client->patch($endpoint, $data)->throw()->json(),
            'delete' => $client->delete($endpoint, $data)->throw()->json(),
            default => throw new \InvalidArgumentException('Método HTTP inválido'),
        };
    }
}
