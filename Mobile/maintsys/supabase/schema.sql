create extension if not exists "pgcrypto";

create type public.user_role as enum ('admin', 'supervisor', 'technician');
create type public.machine_status as enum ('operating', 'attention', 'stopped', 'maintenance');
create type public.occurrence_priority as enum ('low', 'medium', 'high', 'critical');
create type public.occurrence_status as enum ('open', 'underAnalysis', 'inMaintenance', 'finished', 'canceled');
create type public.sync_status as enum ('pending', 'syncing', 'synced', 'error');
create type public.checklist_type as enum ('inspection', 'preventive', 'corrective');

create table if not exists public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  role public.user_role not null default 'technician',
  sector_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists public.sectors (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  description text,
  created_at timestamptz not null default now()
);

alter table public.users
  add constraint users_sector_id_fkey
  foreign key (sector_id) references public.sectors(id) on delete set null;

create table if not exists public.machines (
  id uuid primary key default gen_random_uuid(),
  sector_id uuid references public.sectors(id) on delete restrict,
  name text not null,
  code text not null unique,
  model text,
  manufacturer text,
  status public.machine_status not null default 'operating',
  last_maintenance timestamptz,
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.occurrences (
  id uuid primary key default gen_random_uuid(),
  machine_id uuid not null references public.machines(id) on delete restrict,
  reporter_id uuid references public.users(id) on delete set null,
  technician_id uuid references public.users(id) on delete set null,
  description text not null,
  priority public.occurrence_priority not null default 'medium',
  status public.occurrence_status not null default 'open',
  photos text[] not null default '{}',
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.inspections (
  id uuid primary key default gen_random_uuid(),
  occurrence_id uuid not null references public.occurrences(id) on delete cascade,
  technician_id uuid references public.users(id) on delete set null,
  notes text,
  diagnosis text not null default '',
  checklist_responses jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.correctives (
  id uuid primary key default gen_random_uuid(),
  occurrence_id uuid not null references public.occurrences(id) on delete cascade,
  technician_id uuid references public.users(id) on delete set null,
  solution text not null,
  parts_replaced jsonb not null default '[]'::jsonb,
  photos text[] not null default '{}',
  repair_time_minutes integer not null default 0,
  finished_at timestamptz,
  updated_at timestamptz not null default now()
);

create table if not exists public.preventives (
  id uuid primary key default gen_random_uuid(),
  machine_id uuid not null references public.machines(id) on delete cascade,
  periodicity_days integer not null default 30,
  last_done timestamptz,
  next_due timestamptz not null,
  checklist_template_id uuid,
  updated_at timestamptz not null default now()
);

create table if not exists public.checklists (
  id uuid primary key default gen_random_uuid(),
  type public.checklist_type not null,
  machine_type text not null,
  title text not null,
  items jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.checklist_items (
  id uuid primary key default gen_random_uuid(),
  checklist_id uuid references public.checklists(id) on delete cascade,
  occurrence_id uuid references public.occurrences(id) on delete cascade,
  question text not null,
  answer text,
  observation text,
  photo_path text,
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.users(id) on delete cascade,
  title text not null,
  message text not null,
  related_route text,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.sync_log (
  id uuid primary key default gen_random_uuid(),
  entity_type text not null,
  local_id text not null,
  remote_id uuid,
  status public.sync_status not null default 'pending',
  attempts integer not null default 0,
  error_message text,
  synced_at timestamptz,
  created_at timestamptz not null default now()
);

alter table public.users enable row level security;
alter table public.sectors enable row level security;
alter table public.machines enable row level security;
alter table public.occurrences enable row level security;
alter table public.inspections enable row level security;
alter table public.correctives enable row level security;
alter table public.preventives enable row level security;
alter table public.checklists enable row level security;
alter table public.checklist_items enable row level security;
alter table public.notifications enable row level security;
alter table public.sync_log enable row level security;

create or replace function public.current_user_role()
returns public.user_role
language sql
security definer
stable
as $$
  select role from public.users where id = auth.uid()
$$;

create or replace function public.current_user_sector()
returns uuid
language sql
security definer
stable
as $$
  select sector_id from public.users where id = auth.uid()
$$;

create policy "users self or admin read" on public.users
for select using (id = auth.uid() or public.current_user_role() = 'admin');

create policy "admin manages users" on public.users
for all using (public.current_user_role() = 'admin')
with check (public.current_user_role() = 'admin');

create policy "authenticated read sectors" on public.sectors
for select using (auth.role() = 'authenticated');

create policy "admin manages sectors" on public.sectors
for all using (public.current_user_role() = 'admin')
with check (public.current_user_role() = 'admin');

create policy "authenticated read machines" on public.machines
for select using (auth.role() = 'authenticated');

create policy "admin manages machines" on public.machines
for all using (public.current_user_role() = 'admin')
with check (public.current_user_role() = 'admin');

create policy "occurrences scoped read" on public.occurrences
for select using (
  public.current_user_role() = 'admin'
  or technician_id = auth.uid()
  or reporter_id = auth.uid()
  or exists (
    select 1 from public.machines m
    where m.id = machine_id and m.sector_id = public.current_user_sector()
  )
);

create policy "supervisor admin create occurrences" on public.occurrences
for insert with check (
  public.current_user_role() in ('admin', 'supervisor')
);

create policy "technician assigned update occurrences" on public.occurrences
for update using (
  public.current_user_role() = 'admin'
  or technician_id = auth.uid()
  or reporter_id = auth.uid()
);

create policy "technical records scoped read inspections" on public.inspections
for select using (
  public.current_user_role() = 'admin'
  or technician_id = auth.uid()
  or exists (
    select 1 from public.occurrences o
    where o.id = occurrence_id and (o.technician_id = auth.uid() or o.reporter_id = auth.uid())
  )
);

create policy "technician writes inspections" on public.inspections
for all using (public.current_user_role() in ('admin', 'technician'))
with check (public.current_user_role() in ('admin', 'technician'));

create policy "technical records scoped read correctives" on public.correctives
for select using (
  public.current_user_role() = 'admin'
  or technician_id = auth.uid()
);

create policy "technician writes correctives" on public.correctives
for all using (public.current_user_role() in ('admin', 'technician'))
with check (public.current_user_role() in ('admin', 'technician'));

create policy "authenticated read preventives" on public.preventives
for select using (auth.role() = 'authenticated');

create policy "admin manages preventives" on public.preventives
for all using (public.current_user_role() = 'admin')
with check (public.current_user_role() = 'admin');

create policy "authenticated read checklists" on public.checklists
for select using (auth.role() = 'authenticated');

create policy "admin manages checklists" on public.checklists
for all using (public.current_user_role() = 'admin')
with check (public.current_user_role() = 'admin');

create policy "authenticated manage checklist items" on public.checklist_items
for all using (auth.role() = 'authenticated')
with check (auth.role() = 'authenticated');

create policy "notification owner read" on public.notifications
for select using (user_id = auth.uid() or public.current_user_role() = 'admin');

create policy "notification owner update" on public.notifications
for update using (user_id = auth.uid() or public.current_user_role() = 'admin');

create policy "authenticated write sync log" on public.sync_log
for all using (auth.role() = 'authenticated')
with check (auth.role() = 'authenticated');

insert into storage.buckets (id, name, public)
values ('maintenance-images', 'maintenance-images', false)
on conflict (id) do nothing;

create policy "authenticated upload maintenance images"
on storage.objects for insert
with check (bucket_id = 'maintenance-images' and auth.role() = 'authenticated');

create policy "authenticated read maintenance images"
on storage.objects for select
using (bucket_id = 'maintenance-images' and auth.role() = 'authenticated');
