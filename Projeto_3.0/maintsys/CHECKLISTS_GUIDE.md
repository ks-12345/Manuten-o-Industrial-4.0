# 🎯 Sistema Completo de Checklists Industriais - Guia de Uso

## ✅ O que foi implementado

### 1. **Criação de Máquina com Checklists**

**Localização**: `MaquinaResource.php` → Seção "Checklists da Máquina"

#### Fluxo:
1. Ao criar uma máquina, aparece uma seção com 3 toggles:
   - ✓ Inspeção
   - ✓ Corretiva  
   - ✓ Preventiva

2. **Regra crítica**: Se você selecionar Corretiva ou Preventiva, a Inspeção será automaticamente marcada (obrigatória como base)

3. Após salvar a máquina, os checklists são criados automaticamente via `ChecklistService::criarChecklistsSelecionados()`

#### Exemplo de uso:
```
→ Criar máquina "CNC-001"
→ Selecionar: Inspeção ☑, Corretiva ☑, Preventiva ☑
→ Salvar
✓ Máquina criada + 3 checklists gerados
```

---

### 2. **Gerenciamento de Checklists**

**Localização**: `MaquinaResource` → Relation Manager "Checklists da Máquina"

#### Operações permitidas:
- ✏️ **Criar**: Adicionar novo checklist (inspeção/corretiva/preventiva)
- 📝 **Editar**: Modificar nome, tipo e status
- 🗑️ **Deletar**: Remover (com proteção: não pode deletar inspeção se houver corretiva/preventiva)

---

### 3. **Execução de Checklist**

**Localização**: 
- Inspeção: `InspecaoResource` → Ação "Executar" 
- Corretiva: `CorretivaResource` → Ação "Executar"
- Preventiva: `PreventivaResource` → Ação "Executar"

#### Interface:
Cada pergunta do checklist tem 3 opções de resposta:

```
✓ Conforme         → Equipamento OK, sem problemas
✗ Não Conforme     → Problema encontrado (abre modal obrigatório)
— Não Aplicável    → Item não se aplica à máquina
```

#### Fluxo ao selecionar "Não Conforme":

Um modal automático abre pedindo:
- 📸 **Foto (obrigatória)**: Upload de imagem com a evidência
- 📝 **Descrição (obrigatória)**: Texto descrevendo o problema

⚠️ **Importante**: O modal não fecha sem essas informações!

---

### 4. **Persistência de Dados**

Todas as respostas são salvas em `ChecklistResposta` com:

```
resposta_enum:  'conforme' | 'nao_conforme' | 'nao_aplicavel'
evidencia:      caminho da imagem (S3)
descricao:      texto da não conformidade
```

Ao reabrir o checklist, as respostas já aparecem preenchidas.

---

### 5. **Templates de Checklists por Tipo de Máquina**

**Localização**: `TipoMaquinaResource.php` → Relation Manager para checklists templates

#### Sistema de fallback automático:
1. **Máquina com tipo específico** (ex: CNC)
2. **Sem checklist próprio?** → Busca template do tipo de máquina
3. **Sem template específico?** → Usa template genérico (null tipo_maquina)
4. **Sem nada?** → Cria checklist vazio

---

## 🔧 Arquivos criados/modificados

### Migrations
- ✅ `2026_06_06_000001_add_tipo_maquina_and_template_fields.php`
- ✅ `2026_06_06_000002_add_evidencia_descricao_to_checklist_respostas.php`
- ✅ `2026_06_06_184142_add_resposta_enum_to_checklist_respostas.php`

### Models
- ✅ `ChecklistResposta` - adicionado campo `resposta_enum` com cast RespostaChecklist
- ✅ Corretiva - morphMany checklistRespostas (já existia)
- ✅ Preventiva - morphMany checklistRespostas (já existia)
- ✅ Inspecao - morphMany checklistRespostas (já existia)

### Pages (Livewire)
- ✅ `ExecutarInspecao.php` - lógica de checklist + modal + validações
- ✅ `ExecutarCorretiva.php` - lógica de checklist + modal + validações
- ✅ `ExecutarPreventiva.php` - lógica de checklist + modal + validações (nova)

### Views Blade
- ✅ `executar-inspecao.blade.php` - atualizada com checklist
- ✅ `executar-corretiva.blade.php` - atualizada com checklist
- ✅ `executar-preventiva.blade.php` - atualizada com checklist
- ✅ `components/checklist-executor.blade.php` - componente reutilizável

### Resources
- ✅ `MaquinaResource.php` - seção de checklists adicionada
- ✅ `PreventivaResource.php` - rota para executar adicionada
- ✅ `InspecaoResource.php` - rota para executar já existia
- ✅ `CorretivaResource.php` - rota para executar já existia

---

## 🚀 Como usar

### Cenário 1: Criar máquina com checklists

```
1. Ir para Máquinas → Criar nova
2. Preencher dados básicos
3. Ir até "Checklists da Máquina"
4. Marcar os tipos desejados (inspeção, corretiva, preventiva)
5. Salvar
✓ Máquina e checklists criados!
```

### Cenário 2: Executar inspeção

```
1. Ir para Inspeções → Executar (ação na tabela)
2. Preencher cada pergunta:
   - Selecionar Conforme/Não Conforme/N/A
   - Se Não Conforme → modal abre automaticamente
   - Adicionar foto + descrição
3. Preencher diagnóstico
4. Indicar se precisa peça
5. Finalizar
✓ Checklist e inspeção salvas!
```

### Cenário 3: Adicionar/Editar checklist existente

```
1. Ir para Máquinas → Editar máquina
2. Ir para "Checklists da Máquina"
3. Botões:
   → "Criar" = novo checklist
   → "Editar" = modificar existente
   → "Deletar" = remover (com proteções)
```

---

## ⚙️ Configurações importantes

### Enum RespostaChecklist
Localizado em: `app/Enums/RespostaChecklist.php`

```php
enum RespostaChecklist: string {
    case Conforme = 'conforme';
    case NaoConforme = 'nao_conforme';
    case NaoAplicavel = 'nao_aplicavel';
}
```

### Service ChecklistService
Métodos principais:
- `criarChecklistParaMaquina()` - criar checklist para máquina
- `criarChecklistsSelecionados()` - criar vários por tipo
- `salvarRespostas()` - persistir respostas com validações
- `modeloParaMaquina()` - buscar checklist ou template

### Service ChecklistImportService
Permite importar checklists de:
- 📄 PDF
- 📊 Excel (.xlsx)
- 📝 CSV/TXT

---

## 🔒 Regras de validação

### Criação de checklists
- ✓ Máquina SEM tipo não impede criação de checklists
- ✓ Corretiva/Preventiva exigem Inspeção como base
- ✓ Impossível deletar Inspeção se houver Corretiva/Preventiva

### Execução de checklist
- ✓ TODAS as perguntas devem ser respondidas
- ✓ Respostas com "Não Conforme" EXIGEM foto + descrição
- ✓ Modal de não conformidade não fecha sem dados
- ✓ Validação ocorre antes de finalizar

### Salvamento
- ✓ Respostas são persistidas em `checklist_respostas`
- ✓ Campo `resposta_enum` armazena a resposta padronizada
- ✓ Evidência e descrição são opcionais para Conforme/N/A
- ✓ Evidência e descrição são OBRIGATÓRIAS para Não Conforme

---

## 📊 Estrutura de dados

### checklist_respostas (principais campos)

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|------------|-----------|
| `checklist_pergunta_id` | FK | ✓ | Link para pergunta |
| `checklistable_type` | string | ✓ | Inspecao/Corretiva/Preventiva |
| `checklistable_id` | FK | ✓ | ID do modelo polimórfico |
| `resposta_enum` | enum | ✓ | conforme/nao_conforme/nao_aplicavel |
| `evidencia` | string | ✗* | Path da imagem (S3) |
| `descricao` | text | ✗* | Descrição de não conformidade |

*Obrigatório se resposta_enum = 'nao_conforme'

---

## 🎓 Componente Reutilizável

### `checklist-executor.blade.php`

Use em suas views:

```blade
<x-checklist-executor 
    :checklistModelo="$checklistInspecao"
    :respostasChecklist="$respostasChecklist"
    :modalPerguntaId="$modalPerguntaId"
    :mostrarModalNaoConforme="$mostrarModalNaoConforme" />
```

---

## ❌ Troubleshooting

### Checklist não aparece na execução
- Verificar se máquina tem tipo definido
- Verificar se existe checklist do tipo correspondente
- Consultar `ChecklistService::modeloParaMaquina()`

### Modal não abre ao selecionar "Não Conforme"
- Verificar se `wire:change="selecionarResposta()"` está na view
- Verificar console do browser para erros JavaScript

### Respostas não são salvas
- Verificar se `ChecklistService::salvarRespostas()` é chamado
- Validar estrutura de `$respostasChecklist` (deve ter IDs de perguntas)
- Verificar se disco S3 está configurado (para evidência)

---

## 📝 Próximos passos (sugestões)

1. **Dashboard de Métricas**: Criar gráficos de conformidade
2. **Alertas de Não Conformidade**: Notificar gerentes quando houver
3. **Histórico de Respostas**: Comparar respostas ao longo do tempo
4. **PDF de Relatório**: Gerar PDF com todas as respostas + evidências
5. **API de Integração**: Expor endpoints para integração externa

---

## 🎯 Checklist de funcionalidades

- [x] Criar máquina com seleção de checklists
- [x] 3 tipos de resposta (Conforme, Não Conforme, N/A)
- [x] Modal automático para não conformidade
- [x] Obrigatoriedade de foto + descrição em não conformidade
- [x] Persistência de respostas em BD
- [x] Bloqueio de Corretiva/Preventiva sem Inspeção
- [x] Templates por tipo de máquina
- [x] Importação de checklists via PDF/Excel
- [x] Componente reutilizável de checklist
- [x] Validações em tempo real

---

**Desenvolvido em**: 2026-06-06
**Versão Laravel**: 12
**Versão Filament**: 3.x
