-- Run in Supabase > SQL editor. Safe to re-run. Separate table: does not touch Daily Discipline's "snapshots".
create table if not exists public.rus_snapshots(user_id uuid primary key references auth.users on delete cascade, data jsonb not null, updated_at timestamptz not null default now());
alter table public.rus_snapshots enable row level security;
drop policy if exists "own rows" on public.rus_snapshots;
create policy "own rows" on public.rus_snapshots for all to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);
-- Newer Supabase projects no longer grant API access to new tables automatically (error 42501). Row-level security above still limits each user to their own row.
grant select, insert, update, delete on public.rus_snapshots to authenticated;
