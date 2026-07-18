// Verificação simples de conectividade com o Supabase.
// Não depende de tabelas expostas — apenas confirma que a URL e a chave
// pública falam com o projeto (endpoint de auth).
const url = process.env.SUPABASE_URL ?? process.env.NEXT_PUBLIC_SUPABASE_URL;
const key =
  process.env.SUPABASE_PUBLISHABLE_KEY ?? process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;

if (!url || !key) {
  console.error('ERRO: defina SUPABASE_URL e SUPABASE_PUBLISHABLE_KEY no .env');
  process.exit(1);
}

const res = await fetch(`${url}/auth/v1/settings`, { headers: { apikey: key } });
if (res.ok) {
  console.log(`OK: conectado ao projeto Supabase (${new URL(url).host}) — status ${res.status}`);
  process.exit(0);
} else {
  console.error(`FALHOU: status ${res.status}`);
  process.exit(1);
}
