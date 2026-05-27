# Documentacao do Projeto MaintSys

## 1. Visao geral

O MaintSys e um sistema de manutencao industrial para controle de maquinas, setores e fluxos de manutencao. A aplicacao centraliza:

- cadastro de setores e maquinas;
- abertura e acompanhamento de ocorrencias;
- inspecao tecnica com checklist dinamico;
- criacao e execucao de manutencao corretiva;
- registro de pecas trocadas;
- planejamento de manutencoes preventivas;
- historico tecnico por maquina;
- indicadores de manutencao como MTBF, MTTR e disponibilidade.

A interface principal e o painel administrativo do Filament em `/admin`. A rota raiz `/` redireciona para `/admin/login`.

## 2. Stack tecnica

- PHP `^8.2`
- Laravel `^12.0`
- Filament `^3.3`
- Livewire `^3.8`
- Spatie Laravel Permission `^6.25`
- Filament Shield `^3.9`
- Vite `^7`
- Tailwind CSS `^4`
- Debugbar e Telescope em ambiente de desenvolvimento

Arquivos principais:

- `bootstrap/app.php`: registra rotas web, comandos e health check `/up`.
- `bootstrap/providers.php`: registra `AppServiceProvider` e `AdminPanelProvider`.
- `app/Providers/Filament/AdminPanelProvider.php`: configura o painel Filament.
- `routes/web.php`: redireciona `/` para `/admin/login`.
- `config/maintsys.php`: define o disco usado para uploads.

## 3. Como executar o projeto

### Requisitos

- PHP 8.2 ou superior.
- Composer.
- Node.js e npm.
- Extensoes PHP exigidas pelo Laravel e, para testes SQLite, `pdo_sqlite`.

### Instalacao local

```bash
composer install
npm install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
npm run build
php artisan serve
```

Depois acesse:

- Aplicacao: `http://localhost:8000`
- Login Filament: `http://localhost:8000/admin/login`

### Modo desenvolvimento

O `composer.json` possui script para subir servidor, fila, logs e Vite:

```bash
composer run dev
```

Esse comando executa, via `concurrently`:

- `php artisan serve`
- `php artisan queue:listen --tries=1 --timeout=0`
- `php artisan pail --timeout=0`
- `npm run dev`

### Testes

```bash
php artisan test
```

ou:

```bash
composer test
```

O teste funcional principal esta em `tests/Feature/MaintenanceFlowTest.php`.

## 4. Variaveis de ambiente importantes

Arquivo base: `.env.example`.

| Variavel | Uso |
| --- | --- |
| `APP_URL` | URL base da aplicacao. |
| `APP_DEBUG` | Habilita/desabilita debug. |
| `TELESCOPE_ENABLED` | Controle do Telescope em desenvolvimento. |
| `DB_CONNECTION` | Conexao do banco. O exemplo usa `sqlite`. |
| `SESSION_DRIVER` | Driver de sessao. O exemplo usa `database`. |
| `QUEUE_CONNECTION` | Driver de filas. O exemplo usa `database`. |
| `FILESYSTEM_DISK` | Disco padrao do Laravel. |
| `MAINTSYS_UPLOAD_DISK` | Disco usado pelos uploads do MaintSys. Padrao: `public`. |
| `SUPABASE_STORAGE_*` | Configuracao opcional para uploads via Supabase/S3. |

## 5. Estrutura de diretorios

```text
app/
  Enums/                 Estados e tipos do dominio
  Filament/Resources/    Telas CRUD e acoes do painel
  Livewire/              Componentes interativos de checklist
  Models/                Models Eloquent e relacionamentos
  Providers/             Providers da aplicacao e Filament
  Services/              Regras de negocio e fluxos
config/
  maintsys.php           Configuracao especifica do sistema
  filesystems.php        Discos local, public, s3 e supabase
database/
  migrations/            Schema do banco
  seeders/               Dados iniciais e checklists demo
resources/
  views/                 Views Blade e Livewire
routes/
  web.php                Rota raiz
  console.php            Comandos Artisan
tests/
  Feature/               Testes funcionais
```

## 6. Rotas HTTP

### Rotas da aplicacao

| Metodo | URI | Nome | Descricao |
| --- | --- | --- | --- |
| `GET|HEAD` | `/` | sem nome | Redireciona para `/admin/login`. |
| `GET|HEAD` | `/up` | sem nome | Health check padrao do Laravel. |

### Autenticacao e dashboard Filament

| Metodo | URI | Nome | Descricao |
| --- | --- | --- | --- |
| `GET|HEAD` | `/admin/login` | `filament.admin.auth.login` | Tela de login. |
| `POST` | `/admin/logout` | `filament.admin.auth.logout` | Logout. |
| `GET|HEAD` | `/admin` | `filament.admin.pages.dashboard` | Dashboard autenticado. |

Todas as rotas do painel usam middleware do Filament, sessao, CSRF, bindings e autenticacao, exceto login.

### Resources Filament

| Resource | Listagem | Criacao | Edicao | Execucao |
| --- | --- | --- | --- | --- |
| Setores | `/admin/setors` | `/admin/setors/create` | `/admin/setors/{record}/edit` | - |
| Maquinas | `/admin/maquinas` | `/admin/maquinas/create` | `/admin/maquinas/{record}/edit` | - |
| Ocorrencias | `/admin/ocorrencias` | `/admin/ocorrencias/create` | `/admin/ocorrencias/{record}/edit` | acoes na tabela |
| Inspecoes | `/admin/inspecaos` | `/admin/inspecaos/create` | `/admin/inspecaos/{record}/edit` | `/admin/inspecaos/{record}/executar` |
| Corretivas | `/admin/corretivas` | `/admin/corretivas/create` | `/admin/corretivas/{record}/edit` | `/admin/corretivas/{record}/executar` |
| Preventivas | `/admin/preventivas` | `/admin/preventivas/create` | `/admin/preventivas/{record}/edit` | - |
| Checklist Modelos | `/admin/checklist-modelos` | `/admin/checklist-modelos/create` | `/admin/checklist-modelos/{record}/edit` | - |
| Checklist Perguntas | `/admin/checklist-perguntas` | `/admin/checklist-perguntas/create` | `/admin/checklist-perguntas/{record}/edit` | - |
| Pecas Trocadas | `/admin/peca-trocadas` | `/admin/peca-trocadas/create` | `/admin/peca-trocadas/{record}/edit` | - |

Observacao: alguns slugs seguem a convencao automatica do Filament gerada a partir do nome do model, por exemplo `setors`, `inspecaos` e `peca-trocadas`.

### Rotas auxiliares

| URI | Origem | Uso |
| --- | --- | --- |
| `/livewire/update` | Livewire | Atualizacao de componentes. |
| `/livewire/upload-file` | Livewire | Upload temporario de arquivos. |
| `/livewire/preview-file/{filename}` | Livewire | Preview de upload. |
| `/storage/{path}` | Laravel filesystem | Servir arquivos locais. |
| `/_debugbar/*` | Debugbar | Ferramentas de debug em desenvolvimento. |
| `/filament/exports/{export}/download` | Filament | Download de exportacoes. |
| `/filament/imports/{import}/failed-rows/download` | Filament | Download de falhas de importacao. |

## 7. Painel Filament

Provider: `app/Providers/Filament/AdminPanelProvider.php`.

Configuracao:

- id do painel: `admin`;
- path: `/admin`;
- login habilitado;
- cor primaria: Amber;
- Resources descobertos automaticamente em `app/Filament/Resources`;
- dashboard padrao do Filament;
- widgets padrao `AccountWidget` e `FilamentInfoWidget`;
- autenticacao via `Filament\Http\Middleware\Authenticate`.

### Controle de acesso

O model `User` implementa `FilamentUser`.

```php
public function canAccessPanel(Panel $panel): bool
{
    return true;
}
```

Atualmente qualquer usuario autenticado pode acessar o painel. O model tambem usa `Spatie\Permission\Traits\HasRoles` e possui helpers:

- `isTecnico()`
- `isSupervisor()`
- `isAdmin()`

O seeder cria os roles `admin`, `tecnico` e `supervisor`.

## 8. Modelo de dominio

### Entidades principais

- `Setor`: area fisica/organizacional onde maquinas ficam instaladas.
- `Maquina`: equipamento industrial acompanhado pelo sistema.
- `Ocorrencia`: abertura de problema ou falha em uma maquina.
- `Inspecao`: diagnostico tecnico vinculado a uma ocorrencia.
- `Corretiva`: execucao de manutencao corretiva, normalmente criada a partir de uma inspecao.
- `Preventiva`: manutencao planejada de acordo com periodicidade da maquina.
- `ChecklistModelo`: modelo de checklist por maquina e tipo.
- `ChecklistPergunta`: perguntas de um modelo de checklist.
- `ChecklistResposta`: respostas preenchidas durante inspecoes, corretivas ou preventivas.
- `PecaTrocada`: pecas usadas/substituidas em corretivas.
- `Historico`: log tecnico polimorfico por maquina.
- `User`: usuario autenticado, com roles via Spatie.

### Relacionamentos principais

```text
Setor 1--N Maquina
Setor 1--N Ocorrencia

Maquina 1--N Ocorrencia
Maquina 1--N Inspecao
Maquina 1--N Corretiva
Maquina 1--N Preventiva
Maquina 1--N ChecklistModelo
Maquina 1--N PecaTrocada
Maquina 1--N Historico

Ocorrencia 1--1 Inspecao
Ocorrencia 1--1 Corretiva
Ocorrencia N--1 User aberto_por
Ocorrencia N--1 User tecnico
Ocorrencia 1--N Historico via morphMany

Inspecao N--1 Ocorrencia
Inspecao N--1 Maquina
Inspecao N--1 User tecnico
Inspecao 1--N ChecklistResposta via morphMany
Inspecao 1--N Historico via morphMany

Corretiva N--1 Ocorrencia
Corretiva N--1 Inspecao
Corretiva N--1 Maquina
Corretiva N--1 User tecnico
Corretiva 1--N PecaTrocada
Corretiva 1--N ChecklistResposta via morphMany
Corretiva 1--N Historico via morphMany

Preventiva N--1 Maquina
Preventiva N--1 User tecnico
Preventiva 1--N ChecklistResposta via morphMany

ChecklistModelo 1--N ChecklistPergunta
ChecklistPergunta 1--N ChecklistResposta
ChecklistResposta N--1 User tecnico
```

## 9. Banco de dados

### Tabelas de infraestrutura Laravel

- `users`
- `password_reset_tokens`
- `sessions`
- `cache`
- `cache_locks`
- `jobs`
- `job_batches`
- `failed_jobs`

### Tabelas de permissoes

Criadas por Spatie Permission:

- `permissions`
- `roles`
- `model_has_permissions`
- `model_has_roles`
- `role_has_permissions`

### `setores`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `id` | bigint | PK |
| `nome` | string | obrigatorio |
| `codigo` | string nullable unique | codigo do setor |
| `descricao` | text nullable | descricao livre |
| `responsavel` | string nullable | responsavel do setor |
| `localizacao` | string nullable | localizacao fisica |
| `ativo` | boolean | padrao `true` |
| `timestamps` | timestamps | auditoria |
| `deleted_at` | soft delete | exclusao logica |

### `maquinas`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `setor_id` | FK `setores` | cascade on delete |
| `nome` | string | obrigatorio |
| `modelo` | string nullable | modelo |
| `fabricante` | string nullable | fabricante |
| `numero_serie` | string nullable unique | numero de serie |
| `patrimonio` | string nullable unique | patrimonio |
| `tensao` | string nullable | tensao |
| `potencia` | string nullable | potencia |
| `data_aquisicao` | date nullable | aquisicao |
| `data_instalacao` | date nullable | instalacao |
| `status` | string | padrao `operando` |
| `foto` | string nullable | caminho do upload |
| `observacoes` | text nullable | observacoes |
| `ativo` | boolean | padrao `true` |
| `periodicidade_preventiva` | string nullable | enum de periodicidade |
| `ultima_preventiva` | date nullable | ultima execucao |
| `proxima_preventiva` | date nullable | proxima prevista |
| `pos_x` / `pos_y` | integer nullable | posicao opcional |
| `timestamps` | timestamps | auditoria |
| `deleted_at` | soft delete | exclusao logica |

### `ocorrencias`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `codigo` | string unique | gerado como `OC-00001`, `OC-00002` etc. |
| `maquina_id` | FK `maquinas` | cascade on delete |
| `setor_id` | FK `setores` | setor da maquina |
| `aberto_por` | FK `users` | usuario que abriu |
| `tecnico_id` | FK `users` nullable | tecnico responsavel |
| `titulo` | string | titulo |
| `descricao` | text | descricao do problema |
| `prioridade` | string | padrao `media` |
| `status` | string | padrao `aberto` |
| `foto` | string nullable | evidencias |
| `assumido_em` | timestamp nullable | inicio do atendimento |
| `finalizado_em` | timestamp nullable | fechamento |
| `observacoes_tecnico` | text nullable | observacao final |
| `timestamps` | timestamps | auditoria |
| `deleted_at` | soft delete | exclusao logica |

### `inspecoes`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `ocorrencia_id` | FK `ocorrencias` | cascade on delete |
| `maquina_id` | FK `maquinas` | maquina inspecionada |
| `tecnico_id` | FK `users` | tecnico |
| `diagnostico` | text nullable | resumo montado a partir do checklist |
| `observacoes` | text nullable | observacoes |
| `outro_problema` | boolean | padrao `false` |
| `descricao_outro_problema` | text nullable | complemento |
| `status` | string | padrao `em_andamento` |
| `iniciado_em` | timestamp nullable | inicio |
| `finalizado_em` | timestamp nullable | fim |
| `timestamps` | timestamps | auditoria |

### `corretivas`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `ocorrencia_id` | FK `ocorrencias` | cascade on delete |
| `inspecao_id` | FK `inspecoes` nullable | origem da corretiva |
| `maquina_id` | FK `maquinas` | maquina corrigida |
| `tecnico_id` | FK `users` | tecnico |
| `problema_identificado` | text | problema |
| `solucao_aplicada` | text nullable | solucao |
| `resumo_tecnico` | text nullable | resumo |
| `observacoes` | text nullable | observacoes |
| `foto_antes` | string nullable | imagem antes |
| `foto_depois` | string nullable | imagem depois |
| `tempo_reparo_minutos` | integer nullable | duracao |
| `status` | string | padrao `em_andamento` |
| `iniciado_em` | timestamp nullable | inicio |
| `finalizado_em` | timestamp nullable | fim |
| `timestamps` | timestamps | auditoria |

### `preventivas`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `maquina_id` | FK `maquinas` | cascade on delete |
| `tecnico_id` | FK `users` nullable | tecnico |
| `data_prevista` | date | data planejada |
| `data_realizada` | date nullable | execucao |
| `status` | string | padrao `pendente` |
| `periodicidade` | string | periodicidade |
| `observacoes` | text nullable | observacoes |
| `resumo` | text nullable | resumo |
| `tempo_realizado_minutos` | integer nullable | duracao |
| `timestamps` | timestamps | auditoria |

### `checklist_modelos`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `maquina_id` | FK `maquinas` | cascade on delete |
| `tipo` | string | `inspecao`, `preventiva` ou `corretiva` |
| `nome` | string | nome do modelo |
| `descricao` | text nullable | descricao |
| `ativo` | boolean | padrao `true` |
| `timestamps` | timestamps | auditoria |

### `checklist_perguntas`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `checklist_modelo_id` | FK `checklist_modelos` | cascade on delete |
| `pergunta` | string | texto da pergunta |
| `tipo_resposta` | string | `sim_nao`, `ok_problema`, `texto`, `observacao`, `foto` |
| `obrigatorio` | boolean | padrao `true` |
| `ordem` | integer | ordenacao |
| `ajuda` | text nullable | ajuda ao usuario |
| `ativo` | boolean | padrao `true` |
| `timestamps` | timestamps | auditoria |

### `checklist_respostas`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `checklist_pergunta_id` | FK `checklist_perguntas` | pergunta respondida |
| `tecnico_id` | FK `users` | tecnico |
| `checklistavel_id` | morph id | id de inspecao, corretiva ou preventiva |
| `checklistavel_type` | morph type | classe do model respondido |
| `resposta` | string | valor textual final |
| `observacao` | text nullable | observacao |
| `foto` | string nullable | caminho do upload |
| `conforme` | boolean nullable | resposta booleana normalizada |
| `timestamps` | timestamps | auditoria |

### `pecas_trocadas`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `corretiva_id` | FK `corretivas` | cascade on delete |
| `maquina_id` | FK `maquinas` | maquina |
| `tecnico_id` | FK `users` | tecnico |
| `nome_peca` | string | nome |
| `codigo_peca` | string nullable | codigo |
| `quantidade` | integer | padrao `1` |
| `motivo_troca` | text | motivo |
| `observacoes` | text nullable | observacoes |
| `data_troca` | date | data |
| `timestamps` | timestamps | auditoria |

### `historicos`

| Campo | Tipo | Observacao |
| --- | --- | --- |
| `maquina_id` | FK `maquinas` | cascade on delete |
| `user_id` | FK `users` | usuario |
| `historiavel_id` | morph id | entidade relacionada |
| `historiavel_type` | morph type | classe relacionada |
| `tipo` | string | `ocorrencia`, `inspecao`, `preventiva`, `corretiva` |
| `acao` | string | acao executada |
| `descricao` | text nullable | descricao |
| `dados_anteriores` | json nullable | estado anterior |
| `dados_novos` | json nullable | estado novo |
| `timestamps` | timestamps | auditoria |

## 10. Enums e estados

### Status da maquina

Enum: `App\Enums\StatusMaquina`

| Valor | Significado |
| --- | --- |
| `operando` | maquina disponivel |
| `atencao` | maquina exige atencao |
| `quebrada` | maquina parada/quebrada |
| `manutencao` | maquina em manutencao |

### Status da ocorrencia

Enum: `App\Enums\StatusOcorrencia`

| Valor | Significado |
| --- | --- |
| `aberto` | ocorrencia registrada e nao assumida |
| `em_analise` | tecnico assumiu ou iniciou inspecao |
| `em_manutencao` | corretiva criada/em execucao |
| `finalizado` | fluxo concluido |
| `cancelado` | ocorrencia cancelada |

### Prioridade da ocorrencia

Enum: `App\Enums\PrioridadeOcorrencia`

| Valor | Nivel |
| --- | --- |
| `baixa` | 1 |
| `media` | 2 |
| `alta` | 3 |
| `critica` | 4 |

### Status de inspecao e corretiva

`StatusInspecao` e `StatusCorretiva` usam:

- `em_andamento`
- `finalizada`
- `cancelada`

### Status preventiva

Enum: `App\Enums\StatusPreventiva`

- `pendente`
- `realizada`
- `atrasada`
- `cancelada`

### Periodicidade preventiva

Enum: `App\Enums\PeriodicidadePreventiva`

| Valor | Dias |
| --- | --- |
| `semanal` | 7 |
| `quinzenal` | 15 |
| `mensal` | 30 |
| `trimestral` | 90 |
| `semestral` | 180 |
| `anual` | 365 |

### Tipos de checklist

Enum: `App\Enums\TipoChecklist`

- `inspecao`
- `preventiva`
- `corretiva`

### Tipos de resposta

Enum: `App\Enums\TipoResposta`

- `sim_nao`
- `ok_problema`
- `texto`
- `observacao`
- `foto`

## 11. Fluxo principal de manutencao

O fluxo implementado e testado e:

```text
Ocorrencia aberta
  -> Tecnico assume
  -> Maquina muda para manutencao
  -> Inspecao e iniciada
  -> Tecnico preenche checklist de inspecao
  -> Inspecao e finalizada
  -> Corretiva e criada a partir da inspecao
  -> Tecnico preenche checklist de corretiva e pecas trocadas
  -> Corretiva e finalizada
  -> Ocorrencia e finalizada
  -> Maquina volta para operando
```

### 11.1 Abertura da ocorrencia

Tela: `OcorrenciaResource`

Campos principais:

- maquina;
- setor, preenchido automaticamente a partir da maquina;
- titulo;
- descricao;
- prioridade;
- foto opcional.

Ao criar uma ocorrencia, o model `Ocorrencia` gera automaticamente o codigo:

```text
OC-00001
OC-00002
...
```

### 11.2 Assumir ocorrencia

Acao Filament: `assumir`.

Disponibilidade:

- visivel quando a ocorrencia esta `aberto`;
- exige usuario com role `tecnico`.

Service: `App\Services\OcorrenciaService::assumir`.

Efeitos:

- define `tecnico_id` como o usuario autenticado;
- muda status da ocorrencia para `em_analise`;
- grava `assumido_em`;
- muda status da maquina para `manutencao`;
- registra historico do tipo `ocorrencia`.

### 11.3 Iniciar inspecao

Acao Filament: `iniciar_inspecao`.

Service: `App\Services\InspecaoService::iniciar`.

Efeitos:

- cria uma inspecao para a ocorrencia, se ainda nao existir;
- copia `maquina_id`;
- define `tecnico_id` como usuario autenticado;
- define status da inspecao como `em_andamento`;
- grava `iniciado_em`;
- mantem ocorrencia em `em_analise`;
- redireciona para `/admin/inspecaos/{record}/executar`.

### 11.4 Executar checklist de inspecao

Componente: `App\Livewire\Inspecao\ExecutarChecklistInspecao`.

View: `resources/views/livewire/inspecao/executar-checklist-inspecao.blade.php`.

O componente:

- carrega a inspecao pelo `inspecaoId`;
- localiza a maquina pela ocorrencia;
- busca um `ChecklistModelo` ativo com `tipo = inspecao` e `maquina_id` da maquina;
- lista perguntas ativas ordenadas por `ordem`;
- salva respostas em `checklist_respostas` por relacionamento polimorfico;
- salva fotos em `inspecoes/checklist` no disco `config('maintsys.upload_disk')`;
- monta um diagnostico textual com base nas respostas;
- finaliza a inspecao via `InspecaoService::finalizar`.

Persistencia da resposta:

- `texto`: salva `resposta`;
- `observacao`: usa `observacao` tambem como `resposta`;
- `foto`: salva caminho da foto como `resposta`;
- respostas booleanas: preenchem `conforme` e usam `ok` ou `problema`.

### 11.5 Criar corretiva

Acao Filament: `criar_corretiva`.

Service: `App\Services\CorretivaService::criarAPartirDaInspecao`.

Disponibilidade:

- exige inspecao existente;
- so aparece se ainda nao houver corretiva na ocorrencia.

Efeitos:

- cria corretiva vinculada a ocorrencia, inspecao e maquina;
- define tecnico autenticado;
- usa problema recebido em `$dados['problema']` ou diagnostico da inspecao;
- define status `em_andamento`;
- grava `iniciado_em`;
- muda ocorrencia para `em_manutencao`;
- redireciona para `/admin/corretivas/{record}/executar`.

### 11.6 Executar checklist corretivo

Componente: `App\Livewire\Corretiva\ExecutarChecklistCorretiva`.

View: `resources/views/livewire/corretiva/executar-checklist-corretiva.blade.php`.

O componente:

- carrega corretiva, maquina, ocorrencia, respostas e pecas trocadas;
- busca checklist ativo com `tipo = corretiva` e a maquina da corretiva;
- permite salvar respostas dinamicas;
- permite informar solucao aplicada, resumo tecnico, observacoes, tempo de reparo e foto depois;
- permite adicionar/remover pecas trocadas;
- salva fotos de checklist em `corretivas/checklist`;
- salva foto final em `corretivas/fotos`;
- finaliza corretiva via `CorretivaService::finalizar`.

Persistencia de pecas:

- ignora linhas sem `nome_peca`;
- usa `updateOrCreate` quando ha `id`;
- define `maquina_id`, `tecnico_id`, quantidade minima `1` e `data_troca` como data atual;
- se `motivo_troca` vier vazio, usa `Nao informado`.

### 11.7 Finalizar corretiva

Service: `App\Services\CorretivaService::finalizar`.

Efeitos:

- salva solucao aplicada, resumo tecnico, observacoes, tempo de reparo e foto depois;
- muda status da corretiva para `finalizada`;
- grava `finalizado_em`;
- muda status da maquina para `operando`;
- chama `OcorrenciaService::finalizar`, finalizando tambem a ocorrencia.

## 12. Fluxo de manutencao preventiva

Service: `App\Services\PreventivaService`.

### Gerar proxima preventiva

Metodo: `gerarProximaPreventiva(Maquina $maquina)`.

Regras:

- se a maquina nao tiver `periodicidade_preventiva`, retorna `null`;
- se ja existir preventiva `pendente` para a maquina, nao cria nova;
- cria preventiva com:
  - `maquina_id`;
  - `data_prevista` igual a `proxima_preventiva` da maquina ou data atual;
  - `status = pendente`;
  - `periodicidade` igual ao valor do enum da maquina.

### Finalizar preventiva

Metodo: `finalizar(Preventiva $preventiva, array $dados)`.

Efeitos:

- muda status para `realizada`;
- grava `data_realizada`;
- define `tecnico_id` como usuario autenticado;
- salva resumo, observacoes e tempo;
- atualiza `ultima_preventiva` da maquina;
- calcula nova `proxima_preventiva`;
- tenta gerar uma nova preventiva pendente.

### Gerar preventivas pendentes em lote

Metodo: `gerarPreventivasPendentes()`.

Busca maquinas:

- ativas;
- com periodicidade;
- com `proxima_preventiva` vazia ou ate 3 dias no futuro.

Retorna a quantidade de preventivas criadas.

Observacao: nao ha comando agendado no `routes/console.php` para chamar esse metodo automaticamente. Hoje ele esta disponivel como service.

## 13. Fluxo de dados dos checklists

```text
ChecklistModelo
  -> pertence a uma Maquina
  -> tem um TipoChecklist
  -> contem varias ChecklistPergunta

ChecklistPergunta
  -> define pergunta, tipo de resposta, obrigatoriedade, ordem e status ativo

Durante execucao:
  Inspecao ou Corretiva
    -> busca ChecklistModelo ativo da maquina e tipo
    -> carrega perguntas ativas
    -> usuario responde via Livewire
    -> cada resposta vira ChecklistResposta
    -> ChecklistResposta aponta para Inspecao/Corretiva via morph
```

O design polimorfico permite reutilizar a tabela `checklist_respostas` para inspecoes, corretivas e preventivas.

## 14. Services e responsabilidades

### `OcorrenciaService`

- `assumir(Ocorrencia $ocorrencia)`: tecnico assume e maquina entra em manutencao.
- `finalizar(Ocorrencia $ocorrencia, array $dados = [])`: finaliza ocorrencia e devolve maquina para operando.
- `cancelar(Ocorrencia $ocorrencia, string $motivo)`: cancela ocorrencia.
- `log(...)`: cria registros em `historicos`.

### `InspecaoService`

- `iniciar(Ocorrencia $ocorrencia)`: cria inspecao em andamento.
- `finalizar(Inspecao $inspecao, array $dados)`: salva diagnostico, observacoes e encerra inspecao.

### `CorretivaService`

- `criarAPartirDaInspecao(Inspecao $inspecao, array $dados)`: cria corretiva e muda ocorrencia para manutencao.
- `finalizar(Corretiva $corretiva, array $dados)`: encerra corretiva, maquina e ocorrencia.

### `PreventivaService`

- gera preventiva pendente por maquina;
- finaliza preventiva;
- recalcula proxima preventiva;
- gera preventivas pendentes em lote.

### `HistoricoService`

- `registrar(...)`: cria um registro de historico polimorfico com dados anteriores e novos.

### `IndicadorService`

- `calcularMTBF(Maquina $maquina, int $dias = 30)`: horas medias entre falhas.
- `calcularMTTR(Maquina $maquina, int $dias = 30)`: horas medias de reparo.
- `calcularDisponibilidade(Maquina $maquina, int $dias = 30)`: disponibilidade percentual.
- `indicadoresGerais(int $dias = 30)`: media dos indicadores das maquinas ativas.

## 15. Telas e Resources

### `SetorResource`

CRUD de setores.

Formulario:

- nome;
- codigo;
- descricao;
- responsavel;
- localizacao;
- ativo.

Tabela:

- codigo;
- nome;
- descricao;
- responsavel;
- localizacao;
- ativo;
- criado em.

### `MaquinaResource`

CRUD de maquinas.

Grupo de navegacao: `Infraestrutura`.

Formulario:

- identificacao: setor, nome, modelo, fabricante, numero de serie, patrimonio, tensao, potencia;
- datas e status: aquisicao, instalacao, status;
- preventiva: periodicidade, ultima preventiva, proxima preventiva;
- midia e observacoes: foto, observacoes, ativo.

Tabela:

- foto;
- patrimonio;
- nome;
- setor;
- modelo;
- status;
- proxima preventiva;
- ativo.

Filtros:

- setor;
- status;
- ativo.

### `OcorrenciaResource`

CRUD e orquestracao do fluxo de manutencao.

Grupo de navegacao: `Manutencao`.

Badge:

- mostra total de ocorrencias em `aberto` ou `em_analise`;
- cor `danger` se houver ocorrencias abertas, senao `warning`.

Acoes:

- `Assumir`;
- `Iniciar inspecao`;
- `Executar inspecao`;
- `Criar corretiva`;
- `Executar corretiva`;
- visualizar;
- editar.

### `InspecaoResource`

Resource simples com pagina customizada de execucao.

Rotas:

- index;
- create;
- edit;
- executar.

Acao:

- `Executar`, apontando para a pagina Livewire custom.

### `CorretivaResource`

Resource simples com pagina customizada de execucao.

Rotas:

- index;
- create;
- edit;
- executar.

Acao:

- `Executar`, apontando para a pagina Livewire custom.

### `PreventivaResource`

CRUD basico de preventivas. Formulario e colunas ainda estao vazios no Resource atual.

### `ChecklistModeloResource`

CRUD de modelos de checklist.

Formulario:

- maquina;
- nome;
- tipo de checklist: preventiva, corretiva ou inspecao.

Tabela ainda sem colunas customizadas.

### `ChecklistPerguntaResource`

CRUD basico de perguntas. Formulario e tabela ainda estao vazios no Resource atual.

### `PecaTrocadaResource`

CRUD basico de pecas trocadas. Formulario e tabela ainda estao vazios no Resource atual.

## 16. Uploads e storage

Configuracao:

- `config/maintsys.php`: `upload_disk`;
- `config/filesystems.php`: discos `local`, `public`, `s3` e `supabase`.

Disco usado pelo sistema:

```php
config('maintsys.upload_disk')
```

Padrao:

```env
MAINTSYS_UPLOAD_DISK=public
```

Diretorios de upload:

| Origem | Diretorio |
| --- | --- |
| Foto de maquina | `maquinas` |
| Foto de ocorrencia | `ocorrencias` |
| Checklist de inspecao | `inspecoes/checklist` |
| Checklist de corretiva | `corretivas/checklist` |
| Foto depois da corretiva | `corretivas/fotos` |

Para storage local publico, execute:

```bash
php artisan storage:link
```

Para Supabase/S3, configure:

```env
MAINTSYS_UPLOAD_DISK=supabase
SUPABASE_STORAGE_KEY=
SUPABASE_STORAGE_SECRET=
SUPABASE_STORAGE_REGION=sa-east-1
SUPABASE_STORAGE_BUCKET=maintsys
SUPABASE_STORAGE_ENDPOINT=
SUPABASE_STORAGE_URL=
```

## 17. Seeders

### `DatabaseSeeder`

Cria roles:

- `admin`
- `tecnico`
- `supervisor`

Cria usuarios:

| Email | Senha | Role |
| --- | --- | --- |
| `admin@maintSys.com` | `password` | `admin` |
| `tecnico@maintSys.com` | `password` | `tecnico` |
| `professor@maintSys.com` | `password` | `supervisor` |

Cria setores:

- `US01`: Usinagem 01;
- `US02`: Usinagem 02;
- `CNC`: CNC;
- `ELET`: Eletromecanica;
- `SOLD`: Solda.

Para cada setor, cria uma maquina `Torno CNC {codigo}` com patrimonio `{codigo}-001`.

### `MaintSysDemoChecklistSeeder`

Para cada maquina, cria:

- checklist de inspecao padrao;
- checklist de corretiva padrao.

Perguntas de inspecao:

1. Maquina energiza e responde aos comandos?
2. Ha ruido, vibracao ou aquecimento anormal?
3. Condicao visual de cabos, protecoes e sensores.
4. Registro fotografico da condicao encontrada.

Perguntas de corretiva:

1. Falha corrigida e causa provavel registrada?
2. Teste funcional executado com a maquina em condicao segura?
3. Parametros, protecoes e intertravamentos conferidos?
4. Observacoes finais da intervencao.

## 18. Testes automatizados

### `MaintenanceFlowTest`

Arquivo: `tests/Feature/MaintenanceFlowTest.php`.

O teste cobre o fluxo completo:

1. migra banco do zero;
2. executa seeders;
3. autentica como tecnico;
4. cria ocorrencia;
5. tecnico assume ocorrencia;
6. maquina muda para manutencao;
7. inicia inspecao;
8. preenche checklist via Livewire;
9. finaliza inspecao;
10. cria corretiva a partir da inspecao;
11. preenche checklist corretivo via Livewire;
12. registra peca trocada;
13. finaliza corretiva;
14. ocorrencia fica finalizada;
15. maquina volta para operando.

O teste e ignorado automaticamente se `pdo_sqlite` nao estiver habilitado.

## 19. Indicadores

Service: `App\Services\IndicadorService`.

### MTBF

Metodo:

```php
calcularMTBF(Maquina $maquina, int $dias = 30): float
```

Formula atual:

```text
(dias * 24) / quantidade de corretivas finalizadas no periodo
```

Se nao houver falhas, retorna `0`.

### MTTR

Metodo:

```php
calcularMTTR(Maquina $maquina, int $dias = 30): float
```

Formula atual:

```text
media de tempo_reparo_minutos / 60
```

Retorna horas. Se nao houver corretivas finalizadas com tempo informado, retorna `0`.

### Disponibilidade

Metodo:

```php
calcularDisponibilidade(Maquina $maquina, int $dias = 30): float
```

Formula:

```text
MTBF / (MTBF + MTTR) * 100
```

Se MTBF e MTTR forem zero, retorna `100`.

## 20. Pontos de atencao e melhorias futuras

- `User::canAccessPanel()` retorna `true`; o controle por role ainda precisa ser aplicado ao acesso do painel.
- `PreventivaResource`, `ChecklistPerguntaResource`, `PecaTrocadaResource`, `InspecaoResource` e `CorretivaResource` possuem partes de formulario/tabela ainda vazias.
- `PreventivaService::gerarPreventivasPendentes()` nao esta ligado a um comando Artisan ou scheduler.
- `HistoricoService` existe, mas parte do fluxo usa criacao direta de `Historico` dentro de `OcorrenciaService`.
- Algumas strings do projeto aparentam problema de encoding em arquivos PHP; vale padronizar os arquivos em UTF-8.
- A tabela `checklist_respostas.resposta` e `string`; respostas longas de texto podem exigir migracao para `text` dependendo do uso real.
- Nao ha API REST publica no projeto atual; a interface operacional e o painel Filament.

## 21. Mapa rapido de arquivos

| Area | Arquivo |
| --- | --- |
| Rota raiz | `routes/web.php` |
| Painel Filament | `app/Providers/Filament/AdminPanelProvider.php` |
| Ocorrencias | `app/Models/Ocorrencia.php`, `app/Filament/Resources/OcorrenciaResource.php`, `app/Services/OcorrenciaService.php` |
| Inspecoes | `app/Models/Inspecao.php`, `app/Filament/Resources/InspecaoResource.php`, `app/Livewire/Inspecao/ExecutarChecklistInspecao.php`, `app/Services/InspecaoService.php` |
| Corretivas | `app/Models/Corretiva.php`, `app/Filament/Resources/CorretivaResource.php`, `app/Livewire/Corretiva/ExecutarChecklistCorretiva.php`, `app/Services/CorretivaService.php` |
| Preventivas | `app/Models/Preventiva.php`, `app/Filament/Resources/PreventivaResource.php`, `app/Services/PreventivaService.php` |
| Checklists | `app/Models/ChecklistModelo.php`, `app/Models/ChecklistPergunta.php`, `app/Models/ChecklistResposta.php` |
| Maquinas e setores | `app/Models/Maquina.php`, `app/Models/Setor.php`, `app/Filament/Resources/MaquinaResource.php`, `app/Filament/Resources/SetorResource.php` |
| Historico | `app/Models/Historico.php`, `app/Services/HistoricoService.php` |
| Indicadores | `app/Services/IndicadorService.php` |
| Storage | `config/maintsys.php`, `config/filesystems.php` |
| Seeders | `database/seeders/DatabaseSeeder.php`, `database/seeders/MaintSysDemoChecklistSeeder.php` |
| Teste funcional | `tests/Feature/MaintenanceFlowTest.php` |
