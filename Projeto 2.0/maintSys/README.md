# MaintSys

Sistema web de manutencao industrial construido com Laravel 12, Filament 3 e Livewire.

O projeto organiza setores, maquinas, ocorrencias, inspecoes, corretivas, preventivas, checklists dinamicos, pecas trocadas e historico tecnico.

## Documentacao

A documentacao completa do projeto esta em:

- [docs/DOCUMENTACAO.md](docs/DOCUMENTACAO.md)

Ela cobre arquitetura, rotas, fluxo de dados, banco, modelos, services, enums, telas Filament, componentes Livewire, seeders, testes e configuracao de storage.

## Inicio rapido

```bash
composer install
npm install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
npm run build
php artisan serve
```

Acesse:

- Aplicacao: `http://localhost:8000`
- Painel: `http://localhost:8000/admin/login`

Usuarios criados pelo seeder:

- `admin@maintSys.com` / `password`
- `tecnico@maintSys.com` / `password`
- `professor@maintSys.com` / `password`

## Testes

```bash
php artisan test
```

ou:

```bash
composer test
```
