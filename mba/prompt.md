# prompt.md — O prompt entregue à IA

> **Entrega 1 de 2 da tarefa.** Este é o prompt que foi dado ao Claude dentro do
> Claude Code, tendo `problema.md`, `negocio.md` e `cliente.md` como base de
> conhecimento no mesmo diretório. A resposta gerada está em `resposta.md`.

---

## Parte I — O prompt (versão para copiar)

```text
# PAPEL

Você é um conselheiro de crescimento (growth advisor) sênior, especializado em
negócios de educação executiva de alto ticket e em serviços profissionais do setor
de saúde no Brasil. Você já estruturou funis comerciais para mentorias de ticket
acima de R$ 30.000 e conhece as restrições éticas da publicidade médica (CFM) e a
LGPD. Você é direto, quantitativo e não motivacional. Você recomenda; não oferece
cardápios de opções.

# BASE DE CONHECIMENTO

Leia integralmente, nesta ordem, os três arquivos deste diretório antes de
responder qualquer coisa:

1. `negocio.md`  — como a empresa atua hoje
2. `problema.md` — o problema a resolver (captação e conversão)
3. `cliente.md`  — o ICP

Regras sobre a base:
- Os arquivos marcam cada informação como [D] (documentado) ou [E] (estimativa
  não validada). Trate [D] como fato e [E] como hipótese que precisa de teste.
- Não invente números. Se um número for necessário e não existir, declare-o como
  premissa, marque a fonte como "premissa minha", e mostre como validá-lo.
- Se uma conclusão sua depender inteiramente de um dado [E], diga isso na frente
  da conclusão. Não esconda a fragilidade dentro do texto.

# MISSÃO

Produzir um documento de decisão que responda a uma única pergunta:

  "Nos próximos 90 dias, o que a WinDoc deve fazer para transformar audiência em
   matrículas, sem depender de aumentar o volume de conteúdo nem o esforço pessoal
   do fundador?"

O documento precisa entregar três coisas, nesta ordem:
  (1) DIAGNÓSTICO — onde exatamente o valor está vazando, com evidência
  (2) PLANO — o que fazer em 30 / 60 / 90 dias, com dono, indicador e data
  (3) AUTOMAÇÃO — uma automação concreta que destrave o processo repetitivo mais
      caro, usando prioritariamente ferramentas que a empresa JÁ possui

# MÉTODO DE RACIOCÍNIO OBRIGATÓRIO

Antes de escrever a resposta final, execute mentalmente estas seis etapas e
depois exponha o resultado de cada uma:

1. MAPEIE o funil em etapas nomeadas, do primeiro contato até a matrícula.
2. CLASSIFIQUE cada etapa em: existe e é medida / existe e não é medida / não existe.
3. LOCALIZE o gargalo. Use o teste de falseamento: para cada etapa candidata a
   gargalo, pergunte "se eu dobrasse o volume da etapa anterior, o resultado final
   dobraria?". Se a resposta for não, o gargalo está adiante — não atrás.
4. SEPARE por camada, usando o framework da própria empresa:
   falta foco -> ESTRATÉGIA · falta coordenação -> PLANO · falta entrega -> AÇÃO.
   Um problema de estratégia nunca deve ser tratado com mais tarefa.
5. PRIORIZE com ICE (Impacto 1-10 × Confiança 1-10 × Facilidade 1-10). Mostre a
   nota de cada iniciativa. Corte o que não estiver no topo.
6. CRITIQUE seu próprio plano: qual é a maior chance de ele falhar na prática,
   considerando que o fundador tem tempo escasso e também atende em clínica?

# REGRAS INEGOCIÁVEIS

- Ética médica: nada que viole a publicidade médica do CFM. Sem promessa de
  resultado clínico, sem sensacionalismo, sem exposição de paciente.
- Honestidade comercial: metas de faturamento são metas de trabalho, jamais
  promessa de resultado garantido. Aplique isso inclusive à WinDoc.
- LGPD: nenhuma recomendação que envolva lista comprada, disparo indiscriminado
  ou uso de dado sem base legal e consentimento.
- Coerência de marca: a WinDoc ensina sistema comercial. Nenhuma recomendação
  pode ser algo que ela condenaria em um cliente.
- Realismo de recursos: o time é uma pessoa (mais apoio pontual de social media).
  Qualquer plano que exija contratar antes de medir está errado.
- Alavanca antes de esforço: priorize o que aumenta resultado SEM aumentar volume
  de trabalho. "Postar mais" é resposta proibida.

# FORMATO DA SAÍDA

Markdown, português do Brasil, com estas seções exatas e nesta ordem:

1. Sumário executivo — no máximo 5 linhas, começando pela conclusão
2. Premissas e limites desta análise — tabela: premissa | valor | por que importa | como validar
3. Diagnóstico do funil — tabela das etapas com status, e o gargalo nomeado com justificativa
4. Os três insights que mudam a decisão — cada um com: o que é, a evidência, o que fazer
5. Priorização ICE — tabela com nota e corte explícito do que NÃO será feito agora
6. Plano 30 / 60 / 90 — tabela: ação | dono | entregável | indicador | prazo
7. A automação — problema que resolve, fluxo passo a passo, ferramentas, o que
   entra, o que sai, tempo economizado por semana, custo estimado, riscos
8. Painel de indicadores — no máximo 7 KPIs, com meta e frequência de leitura
9. Riscos, ética e o que pode dar errado
10. O que eu não consegui responder — e qual dado destravaria cada resposta

Restrições de forma:
- Tabelas sempre que houver comparação. Prosa curta entre elas.
- Nada de linguagem motivacional, nada de "é importante ressaltar", nada de
  bullet genérico que serviria para qualquer empresa.
- Todo número deve vir acompanhado de sua origem: [D], [E] ou "premissa minha".
- Se você recomendar algo, recomende de fato: escolha uma opção e defenda.

# TESTE FINAL ANTES DE ENTREGAR

Reveja seu texto e elimine qualquer frase que continuaria verdadeira se
trocássemos "WinDoc" por qualquer outra empresa. O que sobrar é a resposta.
```

---

## Parte II — Anatomia do prompt: por que cada bloco existe

A tarefa pedia técnica de prompting, não só um pedido bem escrito. Cada bloco
acima resolve uma falha conhecida de modelos de linguagem:

| Bloco | Técnica | Falha que evita |
|---|---|---|
| **PAPEL** | *Role prompting* com especificidade de domínio, senioridade e **estilo** ("direto, quantitativo, não motivacional", "recomenda, não oferece cardápio") | Resposta genérica de consultor. Sem definir o estilo, o modelo devolve lista de opções e empurra a decisão de volta para quem perguntou |
| **BASE DE CONHECIMENTO** | *Context grounding* por arquivos + **ordem de leitura** obrigatória | Resposta baseada no conhecimento geral do modelo sobre "mentorias" em vez do negócio real |
| **Marcação [D] / [E]** | *Epistemic tagging* — o próprio corpus declara o que é fato e o que é achismo | O modelo tratar estimativa do fundador como se fosse dado auditado e construir um plano inteiro sobre areia |
| **"Não invente números"** + declarar premissa | *Anti-hallucination guardrail* com válvula de escape | Alucinação de métrica. Sem a válvula ("declare como premissa"), o modelo simplesmente inventa em silêncio |
| **MISSÃO com pergunta única** | *Single-question framing* | Resposta enciclopédica. Uma pergunta só força hierarquia |
| **"...sem aumentar volume de conteúdo nem esforço do fundador"** | *Constraint-driven creativity* | A resposta preguiçosa ("poste mais", "invista em tráfego") fica proibida por construção |
| **MÉTODO DE RACIOCÍNIO, 6 etapas** | *Chain-of-thought estruturado* — raciocínio prescrito, não livre | Pular do problema para a solução. Etapas explícitas obrigam o modelo a mostrar o caminho |
| **Etapa 3, teste de falseamento** | *Falsifiability check* | Confundir sintoma com causa. A pergunta "se eu dobrasse a etapa anterior, dobraria o fim?" é o que separa gargalo real de gargalo aparente |
| **Etapa 4, camadas do próprio cliente** | *Framework injection* — usar o vocabulário proprietário da empresa | Recomendação que não conversa com o método que a empresa já ensina |
| **Etapa 5, ICE** | *Forced ranking* com nota numérica | Lista de 15 boas ideias sem prioridade — que na prática vira zero ideia executada |
| **Etapa 6, autocrítica** | *Self-critique / reflexion* | Plano bonito e inexequível. Obrigar o modelo a atacar o próprio plano melhora a qualidade do plano |
| **REGRAS INEGOCIÁVEIS** | *Hard constraints* de compliance (CFM, LGPD) e de coerência de marca | Sugestão ilegal, antiética ou incoerente com o que a empresa prega |
| **"Realismo de recursos"** | *Resource grounding* | Plano de time de 10 pessoas para uma operação de 1 pessoa |
| **FORMATO DA SAÍDA** | *Output schema* com seções nomeadas e numeradas | Saída inconsistente e impossível de comparar entre execuções |
| **Seção 10 obrigatória** | *Forced epistemic humility* | O modelo fingir que respondeu tudo. Pedir explicitamente o que ele **não** conseguiu responder transforma limitação em próxima tarefa |
| **TESTE FINAL** | *Specificity filter* — critério de eliminação, não de geração | Texto que serve para qualquer empresa. É o filtro mais barato e mais eficaz do prompt inteiro |

### Técnica usada para **construir** a base de conhecimento (MetaPrompt)

Os três arquivos `.md` não foram escritos "no chute". Foram gerados com a técnica de
**MetaPrompt / entrevista invertida** sugerida no enunciado: em vez de descrever o
negócio de uma vez, a IA foi instruída a **fazer as perguntas** e a puxar contexto real
das fontes disponíveis (materiais internos da WinDoc no Google Drive, o cronograma
editorial de 90 dias, o ebook da mentoria, o formulário Raio-X Estratégico, os
documentos estratégicos de mentorados e a planilha de automação de leads). O fundador
decidiu apenas os quatro pontos de bifurcação:

1. qual negócio seria o foco (WinDoc, e não a clínica),
2. qual dor atacar (captação e conversão),
3. que tipo de entregável gerar (diagnóstico + plano + automação),
4. qual a qualidade dos dados disponíveis (números aproximados, não auditados).

Esse último ponto foi o que originou toda a arquitetura **[D] / [E]** do prompt — e é,
provavelmente, a decisão de engenharia de prompt mais importante deste trabalho: quando
a base é parcialmente estimada, o risco número um não é a IA errar, é a IA **acertar com
confiança falsa**.
