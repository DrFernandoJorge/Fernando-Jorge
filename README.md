# Plataforma LMS (micro-SaaS, base WAID)

Plataforma de cursos + área de membros, multi-tenant, em micro-serviços,
sobre **GitHub + Supabase + Vercel**.

## Arquitetura

- **Monorepo** (pnpm + Turborepo) com serviços independentes.
- **Supabase**: Postgres (1 schema por serviço), Auth, Storage. Isolamento por
  **RLS** + **auditoria** automática (`audit.audit_log`).
- **Vercel**: hospeda os apps Next.js (painel admin e vitrine do aluno).
- **CI (GitHub Actions)**: lint + typecheck + testes obrigatórios.

## Estrutura

```
apps/        # front-ends Next.js (Vercel)
services/    # serviços independentes
packages/    # código compartilhado (contracts = validação Zod, common)
supabase/    # migrations SQL (schema + RLS + auditoria)
docs/        # domínio, regras e conformidade
```

## Requisitos

- Node >= 20 (via nvm) e pnpm 11.

## Comandos

```bash
pnpm install     # instala tudo
pnpm typecheck   # checa tipos (estrito)
pnpm test        # roda os testes
pnpm lint        # lint
```

## Status das etapas

- [x] Etapa 0 — Domínio e conformidade documentados (`docs/`)
- [~] Etapa 1 — Fundação: monorepo, dados (RLS + auditoria), CI
- [ ] Conexão GitHub + Supabase + Vercel
- [ ] Serviço Auth (Supabase Auth)
- [ ] Serviços Tenants / Catalog / Members-Area / Enrollments

Regras de negócio: veja [docs/dominio-e-regras.md](docs/dominio-e-regras.md).
Conformidade: veja [docs/conformidade-e-anti-erro.md](docs/conformidade-e-anti-erro.md).
