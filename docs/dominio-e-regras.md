# Domínio e Regras de Negócio — Plataforma LMS (base WAID)

> Extraído do manual/central de ajuda WAID (help.waid.io). Este documento é a
> fonte de verdade das regras. Cada regra vira validação de código + teste.
> **Confirme/ajuste os itens marcados com ❓ antes de implementarmos.**

## 1. Visão geral

Plataforma de cursos online + área de membros (estilo "Netflix do conhecimento"),
multi-tenant (cada criador tem seu espaço isolado), com venda, comunidade,
gamificação, app white-label e automações de IA.

## 2. Papéis (roles)

| Papel | Descrição |
|---|---|
| `admin` | Dono da plataforma (criador). Acesso total ao seu tenant. |
| `subadmin` | Permissões amplas, mas limitadas às áreas de membros que gerencia. |
| `instrutor` | Cria/gerencia conteúdos sob sua administração; pode criar cupons. |
| `membro` (aluno) | Consome conteúdo, participa da comunidade/gamificação. |

## 3. Escopo do MVP (Núcleo do LMS)

Serviços do MVP: **Auth · Tenants · Catalog (Produtos) · Members-Area · Enrollments**.
Fora do MVP (fases seguintes): Pagamentos/WAID Pay, Comunidade, Gamificação,
Certificados, App white-label, Agentes IA, Integrações, Relatórios avançados.

## 4. Entidades e campos (rascunho — confirmar ❓)

### Tenant (criador / conta)
- `id`, `nome`, `subdominio` (único), `dominio_customizado` (opcional), `plano`,
  `status` (ativo/suspenso), `criado_em`.

### Usuário
- `id`, `tenant_id`, `nome`, `email` (único por tenant ❓ ou global?), `role`,
  `status` (ativo/inativo), `tags[]`, `criado_em`.
- Regras: primeiro acesso por e-mail de senha; reset de senha por e-mail;
  desativar/reativar (não excluir — preserva histórico); deeplink de acesso rápido.

### Produto (curso)
- `id`, `tenant_id`, `titulo`, `descricao`, `imagem_capa`, `preco` ❓,
  `visibilidade` (`publico` | `privado` | `nao_listado`),
  `data_lancamento` (opcional), `direcionamento_membro`, `marca_dagua` (on/off),
  `certificado_config`, `comentarios` (permitidos on/off), `status`, `criado_em`.

### Módulo
- `id`, `produto_id`, `titulo`, `ordem`.

### Conteúdo (aula)
- `id`, `modulo_id`, `titulo`, `tipo`, `ordem`, `payload` (varia por tipo).
- Tipos: `video`, `documento`, `quiz`, `audio`, `texto`, `webinar`,
  `entrega`, `galeria`, `flashcards`, `incorporacao`.

### Grupo de Acesso
- `id`, `tenant_id`, `nome`, `produtos[]`, `membros[]`. Liga produtos ↔ membros.

### Matrícula (Enrollment)
- `id`, `usuario_id`, `produto_id` (ou grupo), `data_matricula`,
  `data_expiracao` (opcional), `status` (ativa/revogada).
- Regras: matricular em 1 ou todos os conteúdos; **revogar acesso**;
  **alterar data de expiração** (individual, todas do aluno, ou todos os alunos de um curso);
  importação em lote (rastreável).

### Progresso
- `usuario_id`, `conteudo_id`, `percentual`, `concluido_em`.
- Regra: certificado é liberado por regra de conclusão (❓ qual %? por curso?).

## 5. Regras de negócio-chave (confirmar ❓)

1. **Isolamento multi-tenant**: nenhum dado de um tenant é visível a outro.
2. **Visibilidade do produto**: `publico` aparece na vitrine; `nao_listado` só por
   link direto; `privado` só para matriculados.
3. **Matrícula com expiração**: acesso expira na data; expirado → sem acesso ao conteúdo.
4. **Desativação preserva dados** (soft-delete), nunca exclusão física.
5. **Importação em lote** deve ser idempotente e gerar relatório de erros por linha.
6. **Certificado revogável** após emitido.

## 6. Perguntas abertas para você ❓

- E-mail do membro é único **por tenant** ou **global**?
- Produtos têm preço no MVP ou vendas ficam 100% para a fase de Pagamentos?
- Regra exata de liberação de certificado (% de conclusão, por módulo/curso)?
- Um membro pode pertencer a vários tenants com o mesmo e-mail?
