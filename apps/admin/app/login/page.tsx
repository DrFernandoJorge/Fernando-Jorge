import { login } from './actions';

export default async function LoginPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;

  return (
    <main className="center">
      <form className="card" action={login}>
        <h1>Entrar</h1>
        <p className="muted">Painel administrativo — Plataforma LMS</p>

        {error ? <div className="error">{error}</div> : null}

        <label htmlFor="email">E-mail</label>
        <input id="email" name="email" type="email" autoComplete="email" required />

        <label htmlFor="password">Senha</label>
        <input
          id="password"
          name="password"
          type="password"
          autoComplete="current-password"
          required
        />

        <button type="submit">Entrar</button>
      </form>
    </main>
  );
}
