import { describe, expect, it } from 'vitest';
import { CreateTenant, CreateProduct, CreateEnrollment } from './index.js';

describe('CreateTenant', () => {
  it('aceita subdomínio válido', () => {
    expect(CreateTenant.parse({ nome: 'Escola X', subdominio: 'escola-x' }).plano).toBe('free');
  });
  it('rejeita subdomínio inválido', () => {
    expect(() => CreateTenant.parse({ nome: 'Escola X', subdominio: 'Escola_X!' })).toThrow();
  });
});

describe('CreateProduct', () => {
  it('default de visibilidade é privado', () => {
    expect(CreateProduct.parse({ titulo: 'Curso 1' }).visibilidade).toBe('privado');
  });
});

describe('CreateEnrollment', () => {
  it('rejeita expiração no passado', () => {
    expect(() =>
      CreateEnrollment.parse({
        usuarioId: '00000000-0000-0000-0000-000000000000',
        produtoId: '00000000-0000-0000-0000-000000000001',
        dataExpiracao: '2000-01-01',
      }),
    ).toThrow();
  });
});
