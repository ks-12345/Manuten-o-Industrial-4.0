# Manutenção Industrial 4.0 🏭

> **Status do Projeto:** 🚧 Em desenvolvimento


## 🔗 Links do Projeto

* 🎨 [**Protótipo no Figma**](https://www.figma.com/site/klJakKOgXkbPfyMKsJv23Y/Sem-t%C3%ADtulo?node-id=0-1&t=8XgURJ7HsqHtjIfx-1)
* 📝 [**Documentação no Notion**](https://www.notion.so/Levantamento-de-Requisitos-3120edbe9abf8016814ec73643efdaa2)
* 📋 [**Gestão no Trello**](https://trello.com/b/5FldI0TK/kanban-quadro-modelo)


## 🎯 Objetivo

Este projeto visa a digitalização completa do fluxo de manutenção fabril, substituindo registros físicos por uma inteligência de dados centralizada.


## 🚀 Funcionalidades 

A API fornece rotas e lógica para as seguintes operações:

* **Gestão de Técnicos:** Autenticação e controle de acesso (RBAC).
* **Inventário de Máquinas:** Registro técnico e localização no galpão.
* **Ordens de Serviço (O.S.):** Fluxo digital para manutenções preventivas e corretivas.
* **Histórico de Manutenções:** Log imutável para análise de reincidência de defeitos.
* **Alertas de Status:** Notificações em tempo real sobre paradas críticas.

* **Framework:** Laravel (PHP 8+)
* **Banco de Dados:** MySQL
* **Padrão:** API RESTful (JSON)
* **Arquitetura:** Clean Code e PSRs


##  Levantamento de Requisitos ✔

### Requisitos Funcionais 
|  |  |
| :--- | :--- |
| **Monitoramento** | Coleta de dados (vibração/temp) para detecção de anomalias em tempo real. |
| **Gestão de Ativos** | Controle total do ciclo de vida das máquinas e níveis de permissão. |
| **Alertas/Relatórios** | Dashboards com indicadores críticos como **MTBF** e **MTTR**. |
| **Agendamento** | Manutenção preventiva inteligente baseada no histórico de uso. |

###  Requisitos Não Funcionais 
|  |  |
| :--- | :--- |
| **Performance** | Respostas da interface e processamento em até **3 segundos**. |
| **Segurança** | Autenticação criptografada e protocolos rigorosos de proteção. |
| **Disponibilidade** | SLA mínimo de **99%** de tempo de atividade. |
| **Escalabilidade** | Suporte nativo para até **500 equipamentos** simultâneos. |
| **Confiabilidade** | Rotinas de **backup automático** realizadas diariamente. |



## 📍 Priorização (Matriz MoSCoW)

A estratégia de implementação segue a lógica de priorização para garantir a entrega do núcleo de valor (MVP) primeiro.

| Categoria | 🟢 Críticos (Must Have) | 🟡 Desejáveis (Should/Could Have) |
| :--- | :--- | :--- |
| **Funcional** | Coleta em tempo real, análise preditiva e alertas essenciais. | Relatórios de desempenho avançados e notificações via App. |
| **Técnico** | Resposta, criptografia e backup diário. | Escalabilidade total (500 máquinas) e cross-browser total. |
## Metodologia de Trabalho: Kanban 📋

Adotamos o **Kanban** para garantir um fluxo de entrega contínua, visibilidade de gargalos e rápida adaptação às necessidades do Senai.

| ✅ Vantagens | ⚠️ Desafios |
| :--- | :--- |
| **Flexibilidade Total:** Adaptação rápida a mudanças de prioridade sem quebrar o ritmo. | **Estimativas Flexíveis:** A ausência de sprints rígidos pode dificultar previsões de longo prazo. |
| **Transparência:** Visibilidade imediata do progresso para todos os stakeholders. | **Autodisciplina:** Exige uma equipe madura e altamente engajada com o fluxo. |
| **Fim dos Gargalos:** Identificação instantânea de onde o trabalho está ficando retido. | **Foco na Entrega:** Requer monitoramento constante para evitar tarefas "eternas". |

