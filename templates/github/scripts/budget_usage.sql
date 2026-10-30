-- 주간 감시(free-tier-watch.yml)가 읽는 값. Supabase 마이그레이션으로 넣는다.
-- 게시 작업이 없으면 last_published_as_of 줄을 지운다. 있으면 <게시 테이블>을 고친다.
-- 다른 DB를 쓰면 free_tier_watch.py의 fetch_usage가 같은 이름의 값을 돌려주게 만든다.
create or replace function public.budget_usage()
returns jsonb
language sql
security definer
set search_path = ''
stable
as $$
  select jsonb_build_object(
    'db_bytes', pg_catalog.pg_database_size(pg_catalog.current_database()),
    'storage_bytes', (select coalesce(sum((metadata->>'size')::bigint), 0) from storage.objects),
    'last_published_as_of', (select max(as_of) from public.<게시 테이블> where status = 'published'),
    'rls_disabled_tables', (
      select coalesce(jsonb_agg(c.relname order by c.relname), '[]'::jsonb)
      from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace
      where n.nspname = 'public' and c.relkind in ('r', 'p') and not c.relrowsecurity
    ),
    'signups_24h', (select count(*) from auth.users where created_at > now() - interval '1 day'),
    'signups_7d', (select count(*) from auth.users where created_at > now() - interval '7 days')
  );
$$;

revoke all on function public.budget_usage() from public, anon, authenticated;
grant execute on function public.budget_usage() to service_role;
