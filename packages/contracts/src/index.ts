/**
 * Contratos compartilhados (fonte única de validação).
 * Cada schema Zod espelha uma regra do documento docs/dominio-e-regras.md.
 * Serviços e frontend importam daqui — nada entra no sistema sem passar por aqui.
 */
import { z } from 'zod';

// ---------- enums de domínio ----------
export const Role = z.enum(['admin', 'subadmin', 'instrutor', 'membro']);
export type Role = z.infer<typeof Role>;

export const Visibilidade = z.enum(['publico', 'privado', 'nao_listado']);
export type Visibilidade = z.infer<typeof Visibilidade>;

export const ContentType = z.enum([
  'video',
  'documento',
  'quiz',
  'audio',
  'texto',
  'webinar',
  'entrega',
  'galeria',
  'flashcards',
  'incorporacao',
]);
export type ContentType = z.infer<typeof ContentType>;

// ---------- Tenant ----------
export const CreateTenant = z.object({
  nome: z.string().min(2).max(120),
  // subdomínio: minúsculas, números e hífen; base do isolamento multi-tenant
  subdominio: z
    .string()
    .min(3)
    .max(63)
    .regex(/^[a-z0-9]([a-z0-9-]*[a-z0-9])?$/, 'subdomínio inválido'),
  plano: z.string().default('free'),
});
export type CreateTenant = z.infer<typeof CreateTenant>;

// ---------- Produto ----------
export const CreateProduct = z.object({
  titulo: z.string().min(2).max(160),
  descricao: z.string().max(5000).optional(),
  imagemCapa: z.string().url().optional(),
  visibilidade: Visibilidade.default('privado'),
  dataLancamento: z.coerce.date().optional(),
  marcaDagua: z.boolean().default(false),
  comentariosHabilitados: z.boolean().default(true),
});
export type CreateProduct = z.infer<typeof CreateProduct>;

// ---------- Matrícula ----------
export const CreateEnrollment = z
  .object({
    usuarioId: z.string().uuid(),
    produtoId: z.string().uuid(),
    dataExpiracao: z.coerce.date().optional(),
  })
  .refine((e) => !e.dataExpiracao || e.dataExpiracao.getTime() > Date.now(), {
    message: 'data de expiração deve ser no futuro',
    path: ['dataExpiracao'],
  });
export type CreateEnrollment = z.infer<typeof CreateEnrollment>;

// ---------- Importação em lote (idempotente + rastreável) ----------
export const BulkEnrollRow = z.object({
  email: z.string().email(),
  produtoId: z.string().uuid(),
  dataExpiracao: z.coerce.date().optional(),
});
export type BulkEnrollRow = z.infer<typeof BulkEnrollRow>;
