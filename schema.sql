-- Run once in Supabase > SQL editor. Separate table: does not touch Daily Discipline's "snapshots".
create table if not exists public.rus_snapshots(user_id uuid primary key references auth.users on delete cascade, data jsonb not null, updated_at timestamptz not null default now());
alter table public.rus_snapshots enable row level security;
create policy "own rows" on public.rus_snapshots for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
