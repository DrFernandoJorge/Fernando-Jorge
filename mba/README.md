# Tarefa MBA — Gerar insights, oportunidades e soluções a partir de um problema

**Aluno:** Dr. Fernando Jorge · **Disciplina:** IA aplicada (2026-2, Pós-Graduação/MBA)
**Ferramenta exigida:** Claude Code · **Data:** setembro/2026

---

## O que foi feito

O enunciado pedia (1) pelo menos 3 arquivos de base de conhecimento criados dentro do
Claude Code, (2) um prompt construído a partir deles e (3) a resposta gerada pela IA.

**Negócio escolhido:** WinDoc — Escola de Empreendedorismo e Empresarização Médica.
**Problema escolhido:** captação e conversão (transformar audiência em matrículas).

---

## Os arquivos

### Base de conhecimento (os 3 arquivos exigidos)

| Arquivo | Conteúdo |
|---|---|
| [`problema.md`](problema.md) | O problema, nas 5 seções pedidas: qual é · como é hoje · quem sofre · o que muda se resolver · que dados são necessários |
| [`negocio.md`](negocio.md) | Como a WinDoc atua hoje: o que vende, para quem, de que forma, com que ativos e sob quais restrições |
| [`cliente.md`](cliente.md) | ICP: perfil, faixa etária, gênero, capacidade de desembolso, 3 personas, jornada, gatilhos, objeções e anti-ICP |

### Entrega

| Arquivo | Conteúdo |
|---|---|
| [`prompt.md`](prompt.md) | **Entrega 1** — o prompt dado à IA + a anatomia técnica de cada bloco |
| [`resposta.md`](resposta.md) | **Entrega 2** — a resposta gerada: diagnóstico, plano 30/60/90 e automação |
| [`plano-de-acao.md`](plano-de-acao.md) | Desdobramento operacional do plano: 13 semanas com datas reais, ações, tempo, entregável e painel semanal |

---

## Método usado

1. **MetaPrompt / entrevista invertida** (técnica sugerida no enunciado): em vez de
   descrever o negócio de uma vez, a IA conduziu o levantamento — puxou contexto real das
   fontes existentes (materiais internos da WinDoc, cronograma editorial de 90 dias, ebook
   da mentoria, formulário Raio-X Estratégico, documentos de mentorados, planilha de
   automação de leads) e devolveu apenas as bifurcações que exigiam decisão humana.
2. **Marcação epistêmica `[D]` / `[E]` / `[P]`** em toda a base: documentado, estimado pelo
   fundador, premissa da IA. Como os dados do negócio são parcialmente estimados, o maior
   risco não era a IA errar — era a IA **acertar com confiança falsa**. Toda a arquitetura
   do prompt foi desenhada em torno disso.
3. **Prompt estruturado em 7 blocos** (papel · base · missão · método de raciocínio ·
   restrições · formato de saída · filtro de especificidade), com raciocínio prescrito
   passo a passo, teste de falseamento do gargalo, priorização ICE forçada e autocrítica
   obrigatória. Justificativa técnica de cada bloco na Parte II de `prompt.md`.

---

## Resultado em uma frase

> A WinDoc não tem problema de audiência: o topo de funil planejado é 4 a 7× maior do que
> o necessário para as duas turmas do ano. O valor vaza no **meio** do funil — um salto de
> R$ 0 para R$ 60.000 sem degrau intermediário, nenhuma das 8 etapas do funil medida, e o
> Raio-X Estratégico (o melhor instrumento de vendas da empresa) sendo usado como
> formulário de cadastro. **Instrumentar em 30 dias, converter em 60, automatizar em 90.**

---

## Como submeter no Canvas

A entrega pede dois itens no editor de texto:

1. **O prompt** → copiar o bloco de código da *Parte I* de [`prompt.md`](prompt.md).
2. **A resposta gerada** → copiar o conteúdo de [`resposta.md`](resposta.md).

Vale anexar também o link deste diretório do repositório, que comprova que os arquivos
foram criados dentro do Claude Code (requisito explícito do enunciado).
