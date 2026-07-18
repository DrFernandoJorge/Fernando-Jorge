-- ============================================================================
-- 0003_fix_audit_trigger.sql — Correção de bug encontrado em auditoria
--
-- PROBLEMA (0001): audit.log_change() acessava new.tenant_id diretamente.
-- A tabela tenants.tenant NÃO tem coluna tenant_id (o id dela É o tenant),
-- então o primeiro INSERT em tenants.tenant quebraria com
-- "record new has no field tenant_id".
--
-- CORREÇÃO: ler os campos via JSON (seguro para colunas ausentes); para o
-- schema tenants, usar o próprio id como tenant_id.
-- ============================================================================

create or replace function audit.log_change()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_row    jsonb;
  v_tenant uuid;
  v_id     text;
begin
  v_row := case when tg_op = 'DELETE' then to_jsonb(old) else to_jsonb(new) end;

  v_tenant := coalesce(
    (v_row ->> 'tenant_id')::uuid,
    case when tg_table_schema = 'tenants' then (v_row ->> 'id')::uuid end
  );
  v_id := v_row ->> 'id';

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
