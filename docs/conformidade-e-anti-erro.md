# Conformidade e Anti-erro por Etapa

> Cada etapa só é considerada concluída quando TODOS os itens da sua linha
> "anti-erro" e "conformidade" estão verdes (testados e passando no CI).

## Ferramentas transversais (valem para todos os serviços)

**Anti-erro**
- TypeScript em modo estrito (`strict: true`) — erros de tipo barram o build.
- ESLint + Prettier — padrão de código, sem lixo.
- Validação de entrada com **Zod** em toda borda (nenhum dado entra sem validar).
- Migrations versionadas no Supabase (nada de alterar banco "na mão").
- Testes automatizados (Vitest) — unit + integração por serviço.
- **GitHub Actions**: lint + typecheck + testes obrigatórios; PR não faz merge se falhar.
- Deploy automático na Vercel só após CI verde.

**Conformidade**
- **RLS (Row Level Security)** no Supabase: isolamento de tenant no banco (não só no código).
- Tabela `audit_log` (quem, o quê, quando, antes/depois) — o manual exige "registro de auditoria".
- LGPD: mapa de dados pessoais/sensíveis por tabela; consentimento registrado.
- Segredos só em variáveis de ambiente (nunca no código/git).
- Pagamentos (fase futura): nunca armazenar cartão — sempre via gateway (PCI).

## Matriz por etapa

| Etapa | Serviço | Anti-erro específico | Conformidade específica |
|---|---|---|---|
| 0 | Fundação | Contratos (OpenAPI/Zod) validados; CI base | Doc de dados pessoais; RLS ligado por padrão |
| 1 | Auth (Supabase Auth) | Política de senha forte; rate-limit; testes de login | Auditoria de login; reset seguro por e-mail |
| 2 | Tenants | Teste de isolamento entre tenants | Segregação de dados via RLS por `tenant_id` |
| 3 | Catalog (Produtos) | Validação de schema; transações | Regra de visibilidade; direitos autorais (marca d'água) |
| 4 | Members-Area | Validação de config (tema/menu) | Dados de perfil = LGPD |
| 5 | Enrollments | Idempotência na importação em lote; relatório de erro por linha | Expiração de acesso; revogação auditada |
| 6 | Orquestração | Testes ponta a ponta; health-checks | Relatório de conformidade final |

## Definição de "pronto" (Definition of Done) por serviço

1. Código com tipos estritos, sem erros de lint.
2. Toda entrada validada por Zod.
3. RLS ativa e testada (teste que prova que tenant A não vê dados de tenant B).
4. Ações sensíveis geram registro em `audit_log`.
5. Cobertura de testes das regras de negócio críticas.
6. CI verde no GitHub Actions.
7. Migrations aplicáveis do zero (`supabase db reset` funciona).
