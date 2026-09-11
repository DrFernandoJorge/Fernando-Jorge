# negocio.md — WinDoc, Escola de Empreendedorismo e Empresarização Médica

> Base de conhecimento nº 1 de 3. Descreve **como a empresa atua hoje**.
> Convenção de confiabilidade usada em todos os arquivos:
> **[D]** dado documentado (existe em material interno/público da empresa) ·
> **[E]** estimativa do fundador, ainda **não** validada por sistema.

---

## 1. Identidade

| Campo | Conteúdo |
|---|---|
| Nome | **WinDoc** — Escola de Empreendedorismo e Empresarização Médica [D] |
| Marca-irmã | **WinDoc Club** (comunidade/programa) e **DocRegen** (braço acadêmico) [D] |
| Fundador | Dr. Fernando Jorge — CRM-MG 56.816 · CRM-SP 141.444 · RQE 28918 [D] |
| Clínica-modelo | Instituto Vitalle — Guaxupé/MG (ortopedia, medicina da dor, medicina regenerativa, terapias injetáveis, fisioterapia) [D] |
| Canais | `windoc.com.br` · `@windoc.oficial` (institucional, público 100% médico) · `@dr.fernandojorge` (pessoal, 4.516 seguidores em jul/2026) · WhatsApp comercial · Threads [D] |
| Sede operacional | Remota (Brasil), com componente presencial em Guaxupé/MG [D] |

### Tese central da marca

> *"Você não precisa abandonar o consultório. Precisa empresarizá-lo."* [D]

A promessa não é ensinar medicina. É fazer a travessia **médico técnico → médico líder**:
tirar o faturamento da dependência exclusiva das horas do médico e colocá-lo sobre
sistema, pessoas, oferta e operação.

---

## 2. O que vendemos

### 2.1 Produto principal — Mentoria WinDoc (alto ticket)

| Item | Descrição |
|---|---|
| Formato | Híbrido, **12 meses** [D] |
| Composição | 4 encontros semanais iniciais + 20 encontros quinzenais online (~2h) + 4 sessões individuais de Q&A + 1 imersão presencial + 3 dias presenciais dentro da clínica-modelo (Instituto Vitalle) [D] |
| Investimento | **R$ 60.000,00** [D] |
| Entrega | Aulas expositivas, estudos de caso, acompanhamento individual, documento estratégico personalizado por mentorado, Sprint de 21 dias, plano 30/60/90 [D] |
| Público | Médicos de qualquer especialidade, donos (ou futuros donos) de consultório/clínica [D] |

### 2.2 Ativos metodológicos proprietários (o que nos diferencia)

| Ativo | Função |
|---|---|
| **4 Pilares WinDoc** | Mentalidade e Liderança · Modelo de Negócio e Estratégia · Gestão e Pessoas · Comercial e Crescimento [D] |
| **Raio-X Estratégico WinDoc** | Formulário diagnóstico de ~50 perguntas (faturamento, lucro, retirada, agenda, capacidade ociosa, leads, fontes de paciente, script, follow-up, conversão, objeções, ticket, programas de acompanhamento) [D] |
| **Sprint de 21 Dias** | Protocolo de execução dia a dia com checklist, evidência diária e painel enviado ao mentor [D] |
| **Camadas Estratégia / Plano / Ação** | Framework de diagnóstico: *falta foco → estratégia; falta coordenação → plano; falta entrega → execução* [D] |
| **Método T.E.M.P.O. Nobre** | Arquitetura estratégica da agenda médica (Triagem, Estruturação, Margem, Priorização, Otimização) [D] |
| **Painel de KPIs da Clínica** | Tratado de implementação: métrica de vaidade × KPI de decisão; "estetoscópio empresarial" [D] |
| **Clínica-modelo** | Instituto Vitalle funciona como laboratório real onde o método é testado antes de ser ensinado [D] |

### 2.3 DocRegen — braço acadêmico

Programa técnico-científico de **ortobiologia / medicina regenerativa** (curso em 3 aulas +
apostila "Preparo do Terreno Biológico"), com formulário diagnóstico próprio. [D]
Hoje posiciona autoridade científica; **ainda não opera como degrau comercial de entrada**
para a mentoria (ver `problema.md`, insight 1).

### 2.4 Esteira de produtos — como está hoje

```
Conteúdo gratuito (Instagram/Threads)   → R$ 0
        ↓  (salto de R$ 60.000 — sem degrau intermediário)
Mentoria WinDoc 12 meses                → R$ 60.000
```

DocRegen e WinDoc Club existem, mas **não estão precificados nem posicionados
como oferta de entrada** com função comercial definida. [D/E]

---

## 3. Para quem vendemos

Resumo (o detalhamento está em `cliente.md`): médico brasileiro, dono de consultório ou
clínica, entre ~32 e ~55 anos, majoritariamente fora das capitais (Sul de Minas como
praça-âncora, alcance nacional pelo digital), preso ao convênio e/ou ao plantão, com
agenda ocupada e margem baixa, sem processo comercial estruturado e sem indicadores.

---

## 4. De que forma entregamos (físico / digital / SaaS)

| Camada | Natureza | Como funciona hoje |
|---|---|---|
| Aquisição | **Digital** | Conteúdo orgânico em 2 perfis de Instagram, cronograma de 90 dias com ~130 posts planejados (Reels 40-45%, carrossel 35%, foto+legenda 20-25%), stories diários, Threads [D] |
| Captura de lead | **Digital** | DM do Instagram, WhatsApp comercial, formulário de cadastro integrado a **n8n** que grava em planilha [D] |
| Qualificação | **Manual, pelo fundador** | Conversa por DM/WhatsApp conduzida pessoalmente pelo Dr. Fernando [D] |
| Diagnóstico | **Digital** | Raio-X Estratégico (Google Forms → planilha) [D] |
| Venda | **Manual, pelo fundador** | Sessão de diagnóstico e apresentação de proposta 1:1 [D] |
| Entrega | **Híbrida** | Online quinzenal (Zoom/Meet, com gravação) + imersão presencial + 3 dias na clínica-modelo [D] |
| Material | **Digital** | Apostilas, carrosséis, manuais de sprint, documentos estratégicos individuais, apresentações — produzidos com forte apoio de IA [D] |

**Não é SaaS.** É serviço de alto toque com apoio digital. Existe um projeto de
plataforma LMS multi-tenant em desenvolvimento neste mesmo repositório (`apps/`,
`services/`, `supabase/`), que futuramente hospedará a área de membros — hoje ainda
não está em produção. [D]

---

## 5. Modelo econômico e operação

### 5.1 Estrutura de receita

| Fonte | Situação hoje | Margem | Escalabilidade |
|---|---|---|---|
| Mentoria WinDoc (R$ 60k) | Principal aposta de receita [D] | Alta | **Baixa** — limitada pelas horas do fundador |
| DocRegen (curso) | Produzido, sem operação comercial ativa [D/E] | Alta | Média-alta |
| Instituto Vitalle (clínica) | Receita separada, sustenta o caixa [D] | Média | Baixa (horas médicas) |

### 5.2 Time

| Função | Quem |
|---|---|
| Estratégia, conteúdo, vendas, mentoria, produto | **Dr. Fernando Jorge (100%)** [D] |
| Apoio de social media / produção | Parceiro externo (cronograma de 90 dias foi coproduzido) [D] |
| Comercial dedicado | **Não existe** [D] |
| CRM / operação de funil | **Não existe** — hoje é planilha + n8n + memória [D] |

### 5.3 Ativos já construídos (capital que não está sendo capitalizado)

1. Autoridade clínica real: RQE, dupla inscrição CRM, mídia espontânea (Correio Braziliense), imersão internacional (NASA/Silicon Valley). [D]
2. Clínica própria funcionando como prova viva do método. [D]
3. Biblioteca metodológica densa e original (7 ativos listados em 2.2). [D]
4. Biblioteca de conteúdo pronta: ~130 posts planejados e dezenas de carrosséis já diagramados. [D]
5. Casos de mentorados com documento estratégico formal (ex.: Dr. Euller — baseline R$ 15k/mês, meta 90 dias R$ 30k/mês). [D]
6. Infraestrutura técnica embrionária: n8n integrado a formulário e planilha. [D]

### 5.4 Metas declaradas para o ciclo de 90 dias (jul → nov/2026) [D]

| Métrica | 30 dias | 60 dias | 90 dias |
|---|---|---|---|
| Seguidores @windoc.oficial | +300–500 | +700–1.000 | +1.500–2.000 |
| Seguidores @dr.fernandojorge | +200–400 | +500–800 | +1.000–1.500 (~6.000 total) |
| Engajamento WinDoc | ≥3% | ≥4% | ≥4,5% |
| **DMs qualificados/semana** | 5–10 | 15–25 | **30–50** |
| Turmas WinDoc | — | Turma 1 fechada | Turma 2 fechada |

Essas metas descrevem **topo de funil**. Não existe meta declarada para
lead→sessão diagnóstica, sessão→proposta e proposta→matrícula — que é
exatamente onde `problema.md` localiza o gargalo.

---

## 6. Princípios inegociáveis (restrições que qualquer solução deve respeitar)

1. **Ética médica e publicitária (CFM):** sem promessa de resultado clínico, sem sensacionalismo, sem exposição de paciente identificável.
2. **Honestidade comercial:** metas de faturamento são metas de trabalho, nunca promessa de resultado financeiro garantido — regra já escrita nos documentos entregues a mentorados. [D]
3. **LGPD:** dados de leads médicos e de pacientes tratados com base legal, consentimento registrado e sem lista comprada ou disparo indiscriminado. [D]
4. **Coerência de marca:** a WinDoc ensina sistema comercial. Não pode operar sem sistema comercial próprio.

---

## 7. Fontes deste documento

Materiais internos WinDoc/DocRegen (Google Drive do fundador): cronograma de conteúdo de
90 dias (jul/2026), ebook da Mentoria WinDoc/DocCEO, carrosséis institucionais
(7 Sinais, 4 Pilares, Custo Invisível, Consultório × Empresa, Secretária Converte),
Método T.E.M.P.O. Nobre, Tratado de KPIs da Clínica WinDoc, formulário e respostas do
Raio-X Estratégico, documentos estratégicos do Sprint 21 Dias, planilha de automação de
leads (n8n), memorial técnico do Instituto Vitalle.
