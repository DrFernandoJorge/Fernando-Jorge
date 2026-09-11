# problema.md — O gargalo de captação e conversão da WinDoc

> Base de conhecimento nº 2 de 3. Estrutura exigida: **(a)** qual o problema ·
> **(b)** como é hoje · **(c)** quem sofre · **(d)** o que muda se resolver ·
> **(e)** que dados são necessários.
> Convenção: **[D]** documentado · **[E]** estimativa a validar.

---

## (a) Qual é o problema

**A WinDoc tem oferta de alto valor, autoridade real e método proprietário — mas não
tem um sistema de aquisição e conversão. A venda depende de esforço manual do fundador,
não é medida em nenhuma etapa, e por isso não é previsível nem escalável.**

O problema tem três camadas, nesta ordem de gravidade:

1. **Camada de oferta (estratégia).** A esteira salta de *conteúdo gratuito* direto para
   *R$ 60.000 / 12 meses*. Não existe degrau intermediário pago que transforme audiência
   em cliente pagante, qualificado e aquecido. Um médico que acabou de descobrir o perfil
   só tem duas opções: consumir de graça para sempre, ou assumir o maior compromisso de
   desenvolvimento profissional da carreira dele. [D/E]

2. **Camada de meio de funil (plano).** Não há CRM, não há etapas nomeadas, não há SLA de
   resposta, não há cadência de follow-up e não há dono do processo. O lead que não fecha
   na primeira conversa simplesmente desaparece. [D]

3. **Camada de execução (ação).** Toda a operação comercial — responder DM, qualificar,
   agendar, diagnosticar, propor, dar follow-up — está na mesma pessoa que também produz
   o conteúdo, entrega a mentoria e atende na clínica. [D]

### O paradoxo que precisa ser dito

A WinDoc publica um carrossel chamado *"Antes de comprar mais tráfego, corrija o balde"* e
outro chamado *"Sua secretária atende ou converte?"*. A empresa vende exatamente a
correção deste problema — e opera hoje com o balde furado que ela mesma diagnostica nos
clientes. Enquanto o cronograma de 90 dias fixa metas detalhadas de **topo** de funil
(seguidores, engajamento, DMs), não existe **uma única meta declarada** para
lead → sessão diagnóstica → proposta → matrícula. [D]

---

## (b) Como é hoje

### Fluxo real, etapa por etapa

| # | Etapa | Como acontece hoje | Quem faz | É medido? |
|---|---|---|---|---|
| 1 | Atração | Posts orgânicos em 2 perfis, cronograma de ~130 posts em 90 dias | Fundador + apoio externo | Parcial (métricas de vaidade) [D] |
| 2 | Captura | DM, comentário, WhatsApp, formulário → n8n → planilha | Fundador | **Não** [D] |
| 3 | Qualificação | Conversa manual por DM, sem roteiro fixo nem critério de corte | Fundador | **Não** [D] |
| 4 | Diagnóstico | Raio-X Estratégico (Google Forms), enviado caso a caso | Fundador | **Não** [D] |
| 5 | Sessão de venda | Call 1:1, consultiva, sem estrutura padronizada | Fundador | **Não** [D] |
| 6 | Proposta | Apresentada verbalmente / material avulso | Fundador | **Não** [D] |
| 7 | Follow-up | **Não existe rotina.** Depende de lembrar | Fundador | **Não** [D] |
| 8 | Reativação | **Não existe** | — | **Não** [D] |

### Sintomas observáveis

- A planilha de captação de leads da mentoria (integrada via n8n) está composta
  majoritariamente por **registros de teste** — o canal técnico funciona, o canal
  comercial está vazio. [D]
- O perfil institucional `@windoc.oficial` estava em construção em jul/2026; a audiência
  real mora no perfil pessoal `@dr.fernandojorge` (4.516 seguidores), que atende
  **dois públicos simultâneos** — paciente e médico — com conteúdo alternado. [D]
- Prova social existe (mentorados com documento estratégico formal, como o Dr. Euller),
  mas está sub-utilizada: aparece no cronograma como tema de post, não como ativo
  comercial sistematizado (case estruturado, número auditado, depoimento em vídeo). [D]
- O funil não tem **nome de etapa**. Sem nome, não há medição; sem medição, não há
  diagnóstico; sem diagnóstico, a decisão sobre "o que fazer para vender mais" volta a
  ser sensação — que é justamente o erro que a WinDoc combate nos clientes. [D]

### Engenharia reversa da meta (modelo, não previsão)

Para dimensionar o problema, invertemos a meta declarada de **2 turmas em 90 dias**:

| Premissa | Valor | Origem |
|---|---|---|
| Alunos por turma | 8 | [E] a definir |
| Ticket | R$ 60.000 | [D] |
| Conversão proposta → matrícula | 22% | [E] benchmark de alto ticket consultivo |
| Conversão sessão → proposta | 70% | [E] |
| Conversão lead qualificado → sessão | 30% | [E] |

Trabalhando de trás para frente para **16 matrículas/ano**:

```
16 matrículas ÷ 0,22 ≈  73 propostas
73 propostas  ÷ 0,70 ≈ 104 sessões de diagnóstico
104 sessões   ÷ 0,30 ≈ 347 leads qualificados/ano ≈ 29/mês ≈ 7/semana
```

**Conclusão que muda a decisão:** a meta de topo de funil do cronograma (30–50 DMs
qualificados/semana no dia 90) é **4 a 7 vezes maior** do que os ~7 leads/semana
necessários. Ou seja — **o problema da WinDoc não é falta de audiência. É o meio do
funil.** Comprar mais tráfego ou publicar mais posts antes de corrigir as etapas 3 a 8
é despejar água no balde furado.

**Aviso metodológico:** os percentuais acima são premissas explícitas, não dados. O
valor do modelo não é o número final — é mostrar que **a resposta muda completamente**
dependendo de qual etapa está furada, e que hoje é impossível saber qual é sem medição.

### Custo do problema (dimensionamento, com premissas declaradas)

- **Custo de oportunidade direto:** cada 1 ponto percentual de conversão perdido na etapa
  proposta → matrícula, sobre ~73 propostas/ano, vale ≈ **R$ 44 mil/ano** (0,73 × R$ 60k).
- **Custo de tempo do fundador:** 104 sessões de diagnóstico/ano ≈ 2/semana. Somadas a 34
  encontros de mentoria, produção de conteúdo e atendimento clínico, a agenda do fundador
  vira o teto de crescimento da empresa.
- **Custo invisível:** leads que entraram, não fecharam e nunca mais foram tocados. Sem
  CRM, esse número é literalmente desconhecido — e um lead médico de alto ticket costuma
  precisar de meses de maturação.

---

## (c) Quem sofre

| Ator | Como sofre |
|---|---|
| **Dr. Fernando (fundador)** | Vira o gargalo do próprio negócio. Faz conteúdo, vende, entrega e atende na clínica. Cresce só aumentando as próprias horas — exatamente o que ensina a evitar. Risco real de burnout e de estagnação da receita. |
| **A WinDoc (empresa)** | Receita imprevisível, sem forecast, sem base para contratar, investir em tráfego ou planejar turmas. Não é ainda uma empresa: é uma operação pessoal de alta qualidade. |
| **O médico-lead que não fechou** | Levantou a mão, foi tocado uma vez e nunca mais. Continua preso ao convênio, à agenda cheia com margem baixa e à sensação de que "não dá". Sofre um problema que a WinDoc sabe resolver. |
| **Os mentorados atuais** | Disputam a atenção de um mentor sobrecarregado com tarefas comerciais que poderiam ser sistematizadas. |
| **A equipe do Instituto Vitalle** | Recebe um dono com atenção fracionada entre clínica e escola. |
| **A credibilidade da marca** | Vender "empresarização" sem operar empresarizado é um risco de posicionamento — o dia em que um lead perceber, a autoridade sofre. |

---

## (d) O que muda se resolver

### Efeitos diretos

1. **Previsibilidade.** Com as 8 etapas nomeadas e medidas, "quantos alunos teremos no
   próximo trimestre" deixa de ser torcida e vira cálculo com margem de erro.
2. **Receita destravada sem mais audiência.** Corrigir o meio do funil melhora a receita
   usando exatamente os mesmos leads de hoje.
3. **Tempo do fundador de volta.** Qualificação e preparo de sessão automatizados devolvem
   horas por semana para entrega e produto — as duas atividades que só ele pode fazer.
4. **Degrau de entrada.** Uma oferta intermediária cria caixa recorrente, gera prova social
   em volume e transforma a mentoria de R$ 60k em consequência natural, não em salto de fé.
5. **Base para escalar de verdade.** Só com funil medido faz sentido contratar um comercial,
   investir em tráfego pago ou abrir uma terceira turma.

### Efeito estratégico (o mais importante)

A WinDoc passa a ser **o próprio case**. O funil corrigido, medido e parcialmente
automatizado vira material didático, prova de método e diferencial competitivo:
*"o sistema que eu vou te ensinar é o mesmo que me trouxe você até aqui."*

### Indicadores de sucesso (definição de "resolvido")

| Indicador | Hoje | Meta 90 dias |
|---|---|---|
| Etapas do funil nomeadas e medidas | 0 de 8 | 8 de 8 |
| Tempo médio de 1ª resposta ao lead | Desconhecido | < 4 h úteis |
| Taxa lead qualificado → sessão | Desconhecida | ≥ 30% medida |
| Taxa proposta → matrícula | Desconhecida | ≥ 20% medida |
| Leads sem toque há >30 dias | Desconhecido | 0 |
| Horas/semana do fundador em tarefa comercial manual | ~alto [E] | −50% |
| Receita de oferta de entrada | R$ 0 | > R$ 0, recorrente |

---

## (e) Que dados são necessários

### Já existem e temos acesso

| Dado | Onde está | Estado |
|---|---|---|
| Respostas do Raio-X Estratégico | Google Forms → Google Sheets | Ativo, subutilizado [D] |
| Leads do formulário da mentoria | n8n → Google Sheets | Ativo, base quase vazia [D] |
| Métricas de Instagram (alcance, salvamentos, DMs) | Instagram Insights / Metricool (conectado) | Ativo, histórico curto [D] |
| Cronograma editorial e temas publicados | Documento de 90 dias | Ativo [D] |
| Casos de mentorados | Documentos estratégicos individuais | Ativo, não sistematizado [D] |
| Agenda e capacidade do fundador | Google Calendar | Ativo [D] |

### Faltam e precisam ser criados (bloqueiam a análise)

| Dado que falta | Por que é indispensável | Como capturar |
|---|---|---|
| **Registro de lead com etapa e data** | Sem isso nenhuma taxa de conversão existe | CRM simples (planilha estruturada ou Trello/Notion) desde a semana 1 |
| Origem do lead (post, story, indicação, busca) | Define onde investir esforço | Campo obrigatório na captura |
| Data e resultado de cada sessão de diagnóstico | Mede a etapa mais cara do funil | Registro pós-call, 2 min |
| Objeção declarada na perda | Alimenta conteúdo, script e ajuste de oferta | Campo obrigatório no "perdido" |
| Nº de propostas emitidas e valor | Base do forecast | Registro na emissão |
| Tempo até a 1ª resposta | Maior alavanca isolada de conversão em alto ticket | Timestamp automático |
| Capacidade real de atendimento do fundador | Define o teto de turmas por ano | Bloqueio de agenda |

### Restrições de dados

- **LGPD:** lead médico é titular de dados pessoais. Base legal, consentimento no
  formulário e finalidade declarada. Sem lista comprada, sem disparo indiscriminado. [D]
- **Sigilo:** dados de pacientes do Instituto Vitalle **não entram** nesta análise.
- **Honestidade:** nenhum número estimado pode ser apresentado como resultado real,
  nem em conteúdo, nem em proposta comercial. [D]

---

## Resumo em uma frase

> A WinDoc não tem problema de audiência nem de método: tem um funil sem nome, sem
> medição, sem degrau de entrada e com uma única pessoa em todas as etapas — e por isso
> vende por esforço, não por sistema.
