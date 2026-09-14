-- Auditorías Yacopini BYD — esquema de base de datos compartida (Supabase / Postgres)
-- Pegar en Supabase: Project -> SQL Editor -> New query -> Run.

create table if not exists auditorias (
  id text primary key,
  tipo text not null,
  auditor text,
  fecha date,
  estado text not null default 'en_progreso',
  respuestas jsonb not null default '{}'::jsonb,
  "seccionesPuntaje" jsonb,
  "puntajeGeneral" integer,
  firmante text,
  "firmadoEn" timestamptz,
  "creadoEn" timestamptz not null default now(),
  "actualizadoEn" timestamptz not null default now(),
  "completadoEn" timestamptz
);

create table if not exists fotos (
  "auditoriaId" text not null references auditorias(id) on delete cascade,
  "itemId" text not null,
  "dataUrl" text not null,
  w integer,
  h integer,
  "subidoEn" timestamptz not null default now(),
  primary key ("auditoriaId", "itemId")
);

create table if not exists firmas (
  "auditoriaId" text primary key references auditorias(id) on delete cascade,
  "dataUrl" text not null,
  firmante text,
  "firmadoEn" timestamptz not null default now()
);

create index if not exists auditorias_estado_idx on auditorias (estado);
create index if not exists auditorias_tipo_idx on auditorias (tipo);
create index if not exists auditorias_creadoen_idx on auditorias ("creadoEn" desc);

alter table auditorias enable row level security;
alter table fotos enable row level security;
alter table firmas enable row level security;

-- Sin login de usuarios: cualquiera con la anon key lee y escribe.
-- Ver nota de seguridad en el README antes de usar en producción.
create policy "public all auditorias" on auditorias for all using (true) with check (true);
create policy "public all fotos" on fotos for all using (true) with check (true);
create policy "public all firmas" on firmas for all using (true) with check (true);

grant usage on schema public to anon, authenticated;
grant all on auditorias, fotos, firmas to anon, authenticated;
