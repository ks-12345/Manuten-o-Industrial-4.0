# TODO - OrcamentoResource Select (solicitacao_peca_id)

- [x] Reescrever `OrcamentoResource::form()` para substituir `TextInput` oculto/disabled por `Select` relacional.

- [ ] Configurar `Select` para:
  - [ ] Exibir label no formato `📦 Peça: {nome_peca} — (Ordem: {codigo})` usando `$record->inspecao?->ocorrencia?->codigo`.
  - [ ] Pesquisar/filtrar digitando o nome da peça (`nome_peca`).
  - [ ] Salvar automaticamente o `id` inteiro da peça na coluna `solicitacao_peca_id` (evitar `null` no PostgreSQL).
- [ ] Validar rapidamente que o componente não usa `disabled`/`hidden` indevidamente para garantir a persistência.
- [ ] Rodar checagem do projeto (ex: `php artisan`/lint) se aplicável.
