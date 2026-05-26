# TODO - MaintSys (Entrega A: Inspecao -> Corretiva com checklist dinamico)

## Etapa 1 - Livewire checklist dinamico (Inspecao)
- [x] Criar `app/Livewire/Inspecao/ExecutarChecklistInspecao.php`
- [x] Criar view em `resources/views/livewire/inspecao/executar-checklist-inspecao.blade.php`
- [x] Revisar imports e tipagem (`TemporaryUploadedFile`) para remover erros estaticos
- [x] Ajustar persistencia para `checklist_respostas.resposta` nao quebrar quando a pergunta for foto/observacao

## Etapa 2 - Livewire checklist dinamico (Corretiva)
- [x] Criar `app/Livewire/Corretiva/ExecutarChecklistCorretiva.php`
- [x] Criar view em `resources/views/livewire/corretiva/executar-checklist-corretiva.blade.php`
- [x] Incluir upload e persistencia de `pecas_trocadas` (historico)

## Etapa 3 - Filament Pages custom "Executar"
- [x] Criar `app/Filament/Resources/InspecaoResource/Pages/Executar.php`
- [x] Atualizar `app/Filament/Resources/InspecaoResource.php` para registrar a rota
- [x] Criar `app/Filament/Resources/CorretivaResource/Pages/Executar.php`
- [x] Atualizar `app/Filament/Resources/CorretivaResource.php` para registrar a rota

## Etapa 4 - Integracao no fluxo de Ocorrencias
- [x] Atualizar `app/Filament/Resources/OcorrenciaResource.php`
- [x] Acao "Iniciar Inspecao" (usa `InspecaoService::iniciar` se nao existir)
- [x] Acao "Executar Inspecao" (navega para page custom)
- [x] Acao "Criar Corretiva" a partir da inspecao
- [x] Acao "Executar Corretiva" (navega para page custom)

## Etapa 5 - Storage Supabase
- [x] Configurar disk Supabase/S3 em `config/filesystems.php`
- [x] Criar `config/maintsys.php` com `MAINTSYS_UPLOAD_DISK`
- [x] Migrar uploads de `public` para disk configuravel (`public` local ou `supabase`)

## Etapa 6 - Teste funcional minimo
- [x] Criar seed/registro de checklist modelo/perguntas por maquina
- [x] Criar teste funcional do fluxo: Ocorrencia -> Assumir -> Iniciar inspecao -> Salvar checklist -> Criar/Executar corretiva -> Finalizar
- [x] Executar teste funcional em ambiente com `pdo_sqlite` habilitado
