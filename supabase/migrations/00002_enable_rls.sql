-- RLS para o projeto remoto: a chave publishable (anon) vai no bundle do frontend,
-- então ela só pode ler. Escrita fica restrita à service key (MCP server), que ignora RLS.

alter table teams          enable row level security;
alter table review_rules   enable row level security;
alter table review_history enable row level security;
alter table adrs           enable row level security;

grant select on teams, review_rules, review_history, adrs to anon, authenticated;

create policy "Leitura pública de teams"
  on teams for select to anon, authenticated using (true);

create policy "Leitura pública de review_rules"
  on review_rules for select to anon, authenticated using (true);

create policy "Leitura pública de review_history"
  on review_history for select to anon, authenticated using (true);

create policy "Leitura pública de adrs"
  on adrs for select to anon, authenticated using (true);
