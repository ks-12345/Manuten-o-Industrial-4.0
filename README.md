# Manutenção Industrial 4.0 🏭
> **Status do Projeto:** Em desenvolvimento
##  FIGMA - https://www.figma.com/site/klJakKOgXkbPfyMKsJv23Y/Sem-t%C3%ADtulo?node-id=0-1&t=8XgURJ7HsqHtjIfx-1
## Notion - https://www.notion.so/Levantamento-de-Requisitos-3120edbe9abf8016814ec73643efdaa2

## O Objetivo 🎯
O Senai contratou o desenvolvimento desta API para acabar com as fichas físicas penduradas nas máquinas. O foco principal é garantir a disponibilidade dos equipamentos e a produtividade da planta, migrando para um modelo de dados digital onde técnicos registram intervenções via terminais e gerentes acompanham o status da fábrica.

## 🚀 Funcionalidades

A API fornece rotas e lógica para as seguintes operações:

* **Gestão de Técnicos:** Cadastro de profissionais especializados e sistema de autenticação segura.
* **Inventário de Máquinas:** Registro detalhado de equipamentos, incluindo Número de Série, Modelo, Localização no Galpão e Data de Instalação.
* **Ordens de Serviço (O.S.):** Criação e gerenciamento de ordens de manutenção (Preventiva ou Corretiva), vinculando um técnico responsável a uma máquina específica.
* **Histórico de Manutenções:** Log completo e imutável de todas as intervenções realizadas, facilitando a análise de reincidência de defeitos.
* **Alertas de Status:** Notificações de mudança de estado do equipamento (ex: "Operando", "Parada Crítica" ou "Manutenção Concluída").


* **Framework:** Laravel (PHP)
* **Banco de Dados:** MySQL
* **ORM:** Eloquent
* **Padrão:** API RESTful (JSON)
* **Arquitetura:** Clean Code e padrões PSR


---
### Requisitos Funcionais ✔

* **Monitoramento e Predição:** Coleta de dados (vibração, temperatura, pressão) em tempo real com uso de algoritmos para detecção de anomalias e predição de falhas.
* **Gestão de Ativos e Usuários:** Cadastro detalhado de máquinas e controle de acesso baseado em níveis de permissão (RBAC).
* **Alertas e Relatórios:** Notificações automáticas (e-mail/app) e dashboards com indicadores de performance como **MTBF** (Tempo Médio Entre Falhas) e **MTTR** (Tempo Médio de Reparo).
* **Manutenção:** Agendamento inteligente de intervenções preventivas baseado no histórico de dados armazenado.



---

### Requisitos Não Funcionais ✔

| Atributo | Critério de Sucesso |
| :--- | :--- |
| **Performance** | Processamento de dados e resposta da interface em até 3 segundos. |
| **Disponibilidade** | SLA mínimo de 99% de tempo de atividade. |
| **Segurança** | Autenticação criptografada e protocolos de proteção de dados. |
| **Confiabilidade** | Rotinas de backup automático realizados diariamente. |
| **Escalabilidade** | Suporte nativo para até 500 equipamentos simultâneos. |
| **Manutenibilidade** | Janelas de atualização com interrupção máxima de 10 minutos. |
| **Usabilidade** | Interface UX focada em baixa curva de aprendizado (máx. 4h de treinamento). |

---

### 📍 Priorização (Matriz MoSCoW) 

A estratégia de implementação segue a lógica de priorização para garantir a entrega do núcleo de valor (MVP) primeiro.

| Categoria | 🟢 Críticos (Must Have) | 🟡 Desejáveis (Should/Could Have) |
| :--- | :--- | :--- |
| **Funcional** | Coleta em tempo real, análise preditiva e alertas essenciais. | Relatórios de desempenho avançados e notificações via App. |
| **Técnico** | Resposta, criptografia e backup diário. | Escalabilidade total (500 máquinas) e cross-browser total. |


## Metodologia de Trabalho: Kanban 📋 

Para este projeto, adotamos o **Kanban**, um framework de gestão visual focado na eficiência do fluxo de trabalho e na entrega contínua. 


| ✅ Vantagens | ⚠️ Desafios |
| :--- | :--- |
| **Flexibilidade Total:** Adaptação rápida a mudanças de prioridade sem quebrar o ritmo. | **Estimativas Flexíveis:** A ausência de sprints rígidos pode dificultar previsões de longo prazo. |
| **Transparência:** Visibilidade imediata do progresso para todos os stakeholders. | **Autodisciplina:** Exige uma equipe madura e altamente engajada com o fluxo. |
| **Fim dos Gargalos:** Identificação instantânea de onde o trabalho está ficando retido. | **Foco na Entrega:** Requer monitoramento constante para evitar tarefas "eternas". |
