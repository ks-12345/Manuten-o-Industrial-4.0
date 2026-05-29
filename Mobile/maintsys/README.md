# MaintSys Mobile

Sistema mobile CMMS para manutencao industrial 4.0, construido com Flutter,
Riverpod, Material 3, Isar e Supabase.

## Arquitetura

O app segue Clean Architecture com organizacao feature-first:

- `lib/core`: constantes, enums, modelos compartilhados e contratos base.
- `lib/features`: modulos funcionais com `data`, `domain` e `presentation`.
- `lib/routes`: navegacao central com `go_router`.
- `lib/services`: servicos transversais de banco local, fila e sincronizacao.
- `lib/shared`: widgets reutilizaveis.
- `lib/theme`: tema industrial Material 3.

## Fluxo offline-first

1. A tela envia a acao para um controller Riverpod.
2. O repository salva primeiro no Isar.
3. A UI atualiza imediatamente por estado local.
4. Um item entra na fila de sincronizacao.
5. O `SyncManager` envia pendencias para Supabase quando houver conectividade.
6. O status local muda para sincronizado, pendente ou erro.

## Modulos previstos

- Auth
- Dashboard
- Maquinas
- Setores
- Ocorrencias
- Inspecoes
- Preventivas
- Corretivas
- Checklists
- Historico
- Perfil
- Notificacoes
- Offline Sync

## Supabase

O backend principal devera usar:

- Supabase Auth para usuarios e papeis.
- PostgreSQL com RLS por perfil.
- Supabase Storage para fotos tecnicas.
- Supabase Realtime para status de maquinas e ocorrencias.

Configure as credenciais por `--dart-define`:

```bash
flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```

## Estado atual

Este primeiro corte entrega a fundacao visual e arquitetural:

- app Riverpod com rotas;
- dashboard industrial responsivo;
- lista de maquinas;
- ocorrencias;
- mapa industrial;
- fila offline visual;
- contratos iniciais de banco local e sincronizacao.
