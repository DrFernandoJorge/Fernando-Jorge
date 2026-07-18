import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { logout } from '../login/actions';

export default async function DashboardPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Proteção redundante ao middleware (defesa em profundidade).
  if (!user) {
    redirect('/login');
  }

  return (
    <main className="center">
      <div className="card">
        <h1>Painel</h1>
        <p className="muted">Você está autenticado.</p>

        <label>Usuário</label>
        <input value={user.email ?? ''} readOnly />

        <form action={logout}>
          <button type="submit">Sair</button>
        </form>
      </div>
    </main>
  );
}
