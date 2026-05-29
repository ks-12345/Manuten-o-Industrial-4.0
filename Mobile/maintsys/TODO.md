# TODO - MaintSys Mobile (Offline-first + Isar + SyncQueue)

## Fase 1 — Rotas principais (fluxo end-to-end)
- [ ] Criar/ajustar repositories + providers para Occurrence (lista/detalhe/form)
- [ ] Implementar tela **/occurrences/new** (form offline-first completo)
- [ ] Implementar tela **/occurrences/:id** (detalhe + ações reais)
- [ ] Implementar tela **/occurrences/:id/inspection** (inspeção + checklist responses offline-first)
- [ ] Implementar tela **/occurrences/:id/corrective** (corretiva offline-first + finalizar)
- [ ] Implementar tela **/sync-status** consumindo Isar SyncQueueEntity e disparando sync

## Fase 2 — Complementares
- [ ] Implementar **/machines/:id** (detalhe + histórico + preventiva)
- [ ] Implementar **/preventives** (lista offline-first ordenada + ações)
- [ ] Implementar **/checklist/:checklistId** (render + grava respostas + sync)
- [ ] Implementar **/history** (filtros + histórico offline-first)
- [ ] Implementar **/notifications** (lista + marcar read offline-first)

## Fase 3 — Ajustes finais
- [ ] Atualizar **/dashboard** e **/machines** para remover mocks e ler Isar + refresh remoto
- [ ] Validar e ajustar **/map** se estiver placeholder
- [ ] Rodar `flutter analyze` e `flutter test` e corrigir falhas

