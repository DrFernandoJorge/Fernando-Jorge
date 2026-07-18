-- ============================================================================
-- 0002_rls_hardening.sql — Correção de segurança encontrada em auditoria
--
-- PROBLEMA (0001): as políticas de RLS isolavam por tenant, mas davam
-- LEITURA E ESCRITA a QUALQUER usuário do tenant. Um aluno poderia:
--   - editar/apagar produtos e conteúdos;
--   - criar/revogar matrículas;
--   - alterar o próprio papel para 'admin' (escalada de privilégio).
--
-- CORREÇÃO: políticas por PAPEL (admin/subadmin/instrutor/membro),
-- separando leitura de escrita + RLS na auditoria + GRANTs explícitos.
-- ============================================================================

-- ---------- helpers de papel (security definer evita recursão no RLS) ----------
create or replace function app.member_role()
returns text
language sql stable security definer set search_path = ''
as $$
  select m.role
  from members.membership m
  where m.user_id = auth.uid()
    and m.tenant_id = app.current_tenant_id()
    and m.status = 'ativo'
  limit 1;
$$;

create or replace function app.is_staff()
returns boolean language sql stable
as $$ select app.member_role() in ('admin','subadmin','instrutor'); $$;

create or replace function app.is_admin()
returns boolean language sql stable
as $$ select app.member_role() in ('admin','subadmin'); $$;

-- ---------- remove as políticas permissivas da 0001 ----------
drop policy if exists tenant_isolation     on tenants.tenant;
drop policy if exists membership_isolation on members.membership;
drop policy if exists product_isolation    on catalog.product;
drop policy if exists module_isolation     on catalog.module;
drop policy if exists content_isolation    on catalog.content;
drop policy if exists enrollment_isolation on enrollments.enrollment;
drop policy if exists progress_isolation   on enrollments.progress;

-- ---------- TENANT: todos do tenant leem; só admin altera ----------
create policy tenant_select on tenants.tenant
  for select using (id = app.current_tenant_id());
create policy tenant_update on tenants.tenant
  for update using (id = app.current_tenant_id() and (select app.is_admin()))
  with check (id = app.current_tenant_id());

-- ---------- MEMBERSHIP: cada um vê o próprio vínculo; staff vê todos;
--            só admin cria/edita/remove (impede auto-promoção) ----------
create policy membership_select on members.membership
  for select using (
    tenant_id = app.current_tenant_id()
    and (user_id = auth.uid() or (select app.is_staff()))
  );
create policy membership_insert on members.membership
  for insert with check (tenant_id = app.current_tenant_id() and (select app.is_admin()));
create policy membership_update on members.membership
  for update using (tenant_id = app.current_tenant_id() and (select app.is_admin()))
  with check (tenant_id = app.current_tenant_id());
create policy membership_delete on members.membership
  for delete using (tenant_id = app.current_tenant_id() and (select app.is_admin()));

-- ---------- CATÁLOGO: todos do tenant leem; só staff escreve ----------
create policy product_select on catalog.product
  for select using (tenant_id = app.current_tenant_id());
create policy product_write_ins on catalog.product
  for insert with check (tenant_id = app.current_tenant_id() and (select app.is_staff()));
create policy product_write_upd on catalog.product
  for update using (tenant_id = app.current_tenant_id() and (select app.is_staff()))
  with check (tenant_id = app.current_tenant_id());
create policy product_write_del on catalog.product
  for delete using (tenant_id = app.current_tenant_id() and (select app.is_staff()));

create policy module_select on catalog.module
  for select using (tenant_id = app.current_tenant_id());
create policy module_write_ins on catalog.module
  for insert with check (tenant_id = app.current_tenant_id() and (select app.is_staff()));
create policy module_write_upd on catalog.module
  for update using (tenant_id = app.current_tenant_id() and (select app.is_staff()))
  with check (tenant_id = app.current_tenant_id());
create policy module_write_del on catalog.module
  for delete using (tenant_id = app.current_tenant_id() and (select app.is_staff()));

create policy content_select on catalog.content
  for select using (tenant_id = app.current_tenant_id());
create policy content_write_ins on catalog.content
  for insert with check (tenant_id = app.current_tenant_id() and (select app.is_staff()));
create policy content_write_upd on catalog.content
  for update using (tenant_id = app.current_tenant_id() and (select app.is_staff()))
  with check (tenant_id = app.current_tenant_id());
create policy content_write_del on catalog.content
  for delete using (tenant_id = app.current_tenant_id() and (select app.is_staff()));

-- ---------- MATRÍCULAS: aluno vê só as suas; staff vê todas; só admin gerencia ----------
create policy enrollment_select on enrollments.enrollment
  for select using (
    tenant_id = app.current_tenant_id()
    and (user_id = auth.uid() or (select app.is_staff()))
  );
create policy enrollment_insert on enrollments.enrollment
  for insert with check (tenant_id = app.current_tenant_id() and (select app.is_admin()));
create policy enrollment_update on enrollments.enrollment
  for update using (tenant_id = app.current_tenant_id() and (select app.is_admin()))
  with check (tenant_id = app.current_tenant_id());
create policy enrollment_delete on enrollments.enrollment
  for delete using (tenant_id = app.current_tenant_id() and (select app.is_admin()));

-- ---------- PROGRESSO: aluno lê/grava apenas o próprio; staff lê todos ----------
create policy progress_select on enrollments.progress
  for select using (
    tenant_id = app.current_tenant_id()
    and (user_id = auth.uid() or (select app.is_staff()))
  );
create policy progress_insert on enrollments.progress
  for insert with check (tenant_id = app.current_tenant_id() and user_id = auth.uid());
create policy progress_update on enrollments.progress
  for update using (tenant_id = app.current_tenant_id() and user_id = auth.uid())
  with check (tenant_id = app.current_tenant_id() and user_id = auth.uid());

-- ---------- AUDITORIA: RLS ligado; só admin do tenant lê; ninguém escreve
--            (o trigger security definer continua gravando normalmente) ----------
alter table audit.audit_log enable row level security;
create policy audit_select on audit.audit_log
  for select using (tenant_id = app.current_tenant_id() and (select app.is_admin()));

-- ---------- GRANTS (privilégios de banco; o RLS filtra as linhas) ----------
grant usage on schema tenants, catalog, members, enrollments, audit, app to authenticated;
grant select, insert, update, delete on all tables in schema tenants, catalog, members, enrollments to authenticated;
grant select on audit.audit_log to authenticated;
grant execute on all functions in schema app to authenticated;

-- futuros objetos herdam os privilégios
alter default privileges in schema tenants, catalog, members, enrollments
  grant select, insert, update, delete on tables to authenticated;
