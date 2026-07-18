-- ============================================================================
-- 0001_init.sql — Fundação de dados (Núcleo do LMS)
-- Padrão micro-serviço: 1 SCHEMA por serviço.
-- Conformidade: RLS por tenant + auditoria automática (audit.audit_log).
-- ============================================================================

create extension if not exists pgcrypto;

-- ---------- schemas (um por serviço) ----------
create schema if not exists tenants;
create schema if not exists catalog;
create schema if not exists members;
create schema if not exists enrollments;
create schema if not exists audit;
create schema if not exists app; -- funções auxiliares compartilhadas

-- ============================================================================
-- Helper: tenant do usuário logado (lido do JWT do Supabase Auth)
-- O backend grava tenant_id em app_metadata ao autenticar/matricular.
-- ============================================================================
create or replace function app.current_tenant_id()
returns uuid
language sql
stable
as $$
  select nullif(auth.jwt() -> 'app_metadata' ->> 'tenant_id', '')::uuid;
$$;

-- ============================================================================
-- AUDITORIA (registro de quem/o quê/quando + antes/depois)
-- ============================================================================
create table audit.audit_log (
  id          bigint generated always as identity primary key,
  tenant_id   uuid,
  actor_id    uuid,
  action      text        not null,          -- INSERT | UPDATE | DELETE
  entity      text        not null,          -- schema.tabela
  record_id   text,
  before      jsonb,
  after       jsonb,
  at          timestamptz not null default now()
);
create index audit_log_tenant_idx on audit.audit_log (tenant_id, at desc);

create or replace function audit.log_change()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_tenant uuid;
  v_id     text;
begin
  v_tenant := coalesce(
    (case when tg_op = 'DELETE' then old.tenant_id else new.tenant_id end),
    null
  );
  v_id := coalesce(
    (case when tg_op = 'DELETE' then old.id else new.id end)::text,
    null
  );
  insert into audit.audit_log (tenant_id, actor_id, action, entity, record_id, before, after)
  values (
    v_tenant,
    auth.uid(),
    tg_op,
    tg_table_schema || '.' || tg_table_name,
    v_id,
    case when tg_op in ('UPDATE', 'DELETE') then to_jsonb(old) else null end,
    case when tg_op in ('INSERT', 'UPDATE') then to_jsonb(new) else null end
  );
  return case when tg_op = 'DELETE' then old else new end;
end;
$$;

-- ============================================================================
-- TENANTS (serviço: tenants)
-- ============================================================================
create table tenants.tenant (
  id                  uuid primary key default gen_random_uuid(),
  nome                text        not null,
  subdominio          text        not null unique,
  dominio_customizado text        unique,
  plano               text        not null default 'free',
  status              text        not null default 'ativo' check (status in ('ativo', 'suspenso')),
  criado_em           timestamptz not null default now()
);

-- ============================================================================
-- MEMBERS (serviço: members) — vínculo usuário<->tenant<->papel
-- ============================================================================
create table members.membership (
  id         uuid primary key default gen_random_uuid(),
  tenant_id  uuid        not null references tenants.tenant (id) on delete cascade,
  user_id    uuid        not null references auth.users (id) on delete cascade,
  role       text        not null default 'membro'
               check (role in ('admin', 'subadmin', 'instrutor', 'membro')),
  status     text        not null default 'ativo' check (status in ('ativo', 'inativo')),
  tags       text[]      not null default '{}',
  criado_em  timestamptz not null default now(),
  unique (tenant_id, user_id)
);
create index membership_tenant_idx on members.membership (tenant_id);

-- ============================================================================
-- CATALOG (serviço: catalog) — produtos, módulos, conteúdos
-- ============================================================================
create table catalog.product (
  id                      uuid primary key default gen_random_uuid(),
  tenant_id               uuid        not null references tenants.tenant (id) on delete cascade,
  titulo                  text        not null,
  descricao               text,
  imagem_capa             text,
  visibilidade            text        not null default 'privado'
                            check (visibilidade in ('publico', 'privado', 'nao_listado')),
  data_lancamento         timestamptz,
  marca_dagua             boolean     not null default false,
  comentarios_habilitados boolean     not null default true,
  status                  text        not null default 'rascunho'
                            check (status in ('rascunho', 'publicado', 'arquivado')),
  criado_em               timestamptz not null default now()
);
create index product_tenant_idx on catalog.product (tenant_id);

create table catalog.module (
  id         uuid primary key default gen_random_uuid(),
  tenant_id  uuid        not null references tenants.tenant (id) on delete cascade,
  product_id uuid        not null references catalog.product (id) on delete cascade,
  titulo     text        not null,
  ordem      int         not null default 0,
  criado_em  timestamptz not null default now()
);
create index module_product_idx on catalog.module (product_id);

create table catalog.content (
  id         uuid primary key default gen_random_uuid(),
  tenant_id  uuid        not null references tenants.tenant (id) on delete cascade,
  module_id  uuid        not null references catalog.module (id) on delete cascade,
  titulo     text        not null,
  tipo       text        not null
               check (tipo in ('video','documento','quiz','audio','texto',
                               'webinar','entrega','galeria','flashcards','incorporacao')),
  ordem      int         not null default 0,
  payload    jsonb       not null default '{}',
  criado_em  timestamptz not null default now()
);
create index content_module_idx on catalog.content (module_id);

-- ============================================================================
-- ENROLLMENTS (serviço: enrollments) — matrículas e progresso
-- ============================================================================
create table enrollments.enrollment (
  id             uuid primary key default gen_random_uuid(),
  tenant_id      uuid        not null references tenants.tenant (id) on delete cascade,
  user_id        uuid        not null references auth.users (id) on delete cascade,
  product_id     uuid        not null references catalog.product (id) on delete cascade,
  data_matricula timestamptz not null default now(),
  data_expiracao timestamptz,
  status         text        not null default 'ativa' check (status in ('ativa', 'revogada')),
  unique (user_id, product_id)
);
create index enrollment_tenant_idx on enrollments.enrollment (tenant_id);

create table enrollments.progress (
  id           uuid primary key default gen_random_uuid(),
  tenant_id    uuid        not null references tenants.tenant (id) on delete cascade,
  user_id      uuid        not null references auth.users (id) on delete cascade,
  content_id   uuid        not null references catalog.content (id) on delete cascade,
  percentual   int         not null default 0 check (percentual between 0 and 100),
  concluido_em timestamptz,
  unique (user_id, content_id)
);

-- ============================================================================
-- TRIGGERS DE AUDITORIA (todas as tabelas de negócio)
-- ============================================================================
create trigger audit_tenant       after insert or update or delete on tenants.tenant       for each row execute function audit.log_change();
create trigger audit_membership   after insert or update or delete on members.membership   for each row execute function audit.log_change();
create trigger audit_product      after insert or update or delete on catalog.product      for each row execute function audit.log_change();
create trigger audit_module       after insert or update or delete on catalog.module       for each row execute function audit.log_change();
create trigger audit_content      after insert or update or delete on catalog.content      for each row execute function audit.log_change();
create trigger audit_enrollment   after insert or update or delete on enrollments.enrollment for each row execute function audit.log_change();

-- ============================================================================
-- ROW LEVEL SECURITY — isolamento por tenant (conformidade central)
-- service_role (backend) ignora RLS; usuários finais só enxergam seu tenant.
-- ============================================================================
alter table tenants.tenant           enable row level security;
alter table members.membership       enable row level security;
alter table catalog.product          enable row level security;
alter table catalog.module           enable row level security;
alter table catalog.content          enable row level security;
alter table enrollments.enrollment   enable row level security;
alter table enrollments.progress     enable row level security;

-- tenant: o usuário só vê o próprio tenant
create policy tenant_isolation on tenants.tenant
  for select using (id = app.current_tenant_id());

-- demais tabelas: leitura/escrita restrita ao tenant do JWT
create policy membership_isolation on members.membership
  using (tenant_id = app.current_tenant_id())
  with check (tenant_id = app.current_tenant_id());

create policy product_isolation on catalog.product
  using (tenant_id = app.current_tenant_id())
  with check (tenant_id = app.current_tenant_id());

create policy module_isolation on catalog.module
  using (tenant_id = app.current_tenant_id())
  with check (tenant_id = app.current_tenant_id());

create policy content_isolation on catalog.content
  using (tenant_id = app.current_tenant_id())
  with check (tenant_id = app.current_tenant_id());

create policy enrollment_isolation on enrollments.enrollment
  using (tenant_id = app.current_tenant_id())
  with check (tenant_id = app.current_tenant_id());

create policy progress_isolation on enrollments.progress
  using (tenant_id = app.current_tenant_id())
  with check (tenant_id = app.current_tenant_id());
