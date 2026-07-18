/**
 * Clientes Supabase compartilhados.
 *
 * - createPublicClient: usa a chave PUBLISHABLE (anon). Respeita o RLS.
 *   Use no frontend e em qualquer contexto do usuário final.
 * - createServiceClient: usa a chave SECRET (service_role). IGNORA o RLS.
 *   Use SOMENTE em serviços de backend, nunca no navegador.
 */
import { createClient, type SupabaseClient } from '@supabase/supabase-js';

function required(name: string, value: string | undefined): string {
  if (!value || value.length === 0) {
    throw new Error(`Variável de ambiente ausente: ${name}`);
  }
  return value;
}

type Env = Record<string, string | undefined>;

/** Cliente público (respeita RLS). Seguro para o navegador. */
export function createPublicClient(env: Env = process.env): SupabaseClient {
  const url = required('SUPABASE_URL', env.SUPABASE_URL ?? env.NEXT_PUBLIC_SUPABASE_URL);
  const key = required(
    'SUPABASE_PUBLISHABLE_KEY',
    env.SUPABASE_PUBLISHABLE_KEY ?? env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY,
  );
  return createClient(url, key, { auth: { persistSession: false } });
}

/**
 * Cliente de serviço (ignora RLS). NUNCA use no frontend.
 * A chave secreta só deve existir em variáveis de ambiente do backend.
 */
export function createServiceClient(env: Env = process.env): SupabaseClient {
  const url = required('SUPABASE_URL', env.SUPABASE_URL);
  const key = required('SUPABASE_SECRET_KEY', env.SUPABASE_SECRET_KEY);
  return createClient(url, key, { auth: { persistSession: false } });
}
