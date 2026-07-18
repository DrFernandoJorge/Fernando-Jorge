'use server';

import { z } from 'zod';
import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';

// Anti-erro: valida a entrada antes de tocar no Supabase.
const LoginInput = z.object({
  email: z.string().email('E-mail inválido'),
  password: z.string().min(8, 'Senha muito curta'),
});

export async function login(formData: FormData) {
  const parsed = LoginInput.safeParse({
    email: formData.get('email'),
    password: formData.get('password'),
  });

  if (!parsed.success) {
    const msg = parsed.error.issues[0]?.message ?? 'Dados inválidos';
    redirect('/login?error=' + encodeURIComponent(msg));
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.signInWithPassword(parsed.data);

  if (error) {
    redirect('/login?error=' + encodeURIComponent('Não foi possível entrar. Verifique os dados.'));
  }

  redirect('/dashboard');
}

export async function logout() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  redirect('/login');
}
