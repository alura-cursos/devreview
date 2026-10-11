-- Seed data do DevReview
-- Team ID fixo para facilitar referência no MCP server e nos roteiros do curso

-- Time
insert into teams (id, name) values
  ('11111111-1111-1111-1111-111111111111', 'Frontend'),
  ('22222222-2222-2222-2222-222222222222', 'Backend'),
  ('33333333-3333-3333-3333-333333333333', 'Integrations');

-- Regras de code review
insert into review_rules (team_id, category, severity, active, rule) values
  ('11111111-1111-1111-1111-111111111111', 'security',     'error',   true,  'Nunca expor chaves de API ou tokens em código-fonte'),
  ('11111111-1111-1111-1111-111111111111', 'architecture', 'error',   true,  'Separar lógica de negócio da camada de apresentação'),
  ('11111111-1111-1111-1111-111111111111', 'performance',  'warning', true,  'Evitar renderizações desnecessárias em componentes React'),
  ('11111111-1111-1111-1111-111111111111', 'style',        'warning', true,  'Usar nomenclatura camelCase para variáveis e funções'),
  ('11111111-1111-1111-1111-111111111111', 'architecture', 'warning', false, 'Evitar dependências circulares entre módulos'),
  ('11111111-1111-1111-1111-111111111111', 'style',        'info',    true,  'Documentar funções públicas com JSDoc'),
  ('11111111-1111-1111-1111-111111111111', 'performance',  'info',    true,  'Utilizar lazy loading para rotas secundárias'),
  ('11111111-1111-1111-1111-111111111111', 'security',     'warning', true,  'Validar e sanitizar todos os inputs do usuário'),
  -- Backend
  ('22222222-2222-2222-2222-222222222222', 'security',     'error',   true,  'Usar queries parametrizadas; nunca concatenar input em SQL'),
  ('22222222-2222-2222-2222-222222222222', 'architecture', 'error',   true,  'Manter regras de negócio na camada de serviço, fora dos controllers'),
  ('22222222-2222-2222-2222-222222222222', 'performance',  'warning', true,  'Evitar consultas N+1; usar joins ou carregamento em lote'),
  ('22222222-2222-2222-2222-222222222222', 'security',     'warning', true,  'Aplicar autorização em todos os endpoints, não só autenticação'),
  ('22222222-2222-2222-2222-222222222222', 'style',        'info',    true,  'Usar snake_case para colunas e camelCase para campos de DTO'),
  ('22222222-2222-2222-2222-222222222222', 'performance',  'info',    false, 'Paginar todas as listagens que retornam coleções'),
  -- Integrations
  ('33333333-3333-3333-3333-333333333333', 'security',     'error',   true,  'Validar a assinatura de todo webhook recebido'),
  ('33333333-3333-3333-3333-333333333333', 'architecture', 'error',   true,  'Isolar cada API externa atrás de um adapter com contrato próprio'),
  ('33333333-3333-3333-3333-333333333333', 'performance',  'warning', true,  'Definir timeout e retry com backoff exponencial em chamadas externas'),
  ('33333333-3333-3333-3333-333333333333', 'architecture', 'warning', true,  'Garantir idempotência no processamento de eventos e callbacks'),
  ('33333333-3333-3333-3333-333333333333', 'style',        'info',    true,  'Registrar logs de requisição e resposta sem dados sensíveis'),
  ('33333333-3333-3333-3333-333333333333', 'security',     'warning', false, 'Rotacionar periodicamente credenciais de APIs de terceiros');

-- Histórico de reviews
insert into review_history (team_id, pr_url, pr_number, repo, issues_found, reviewed_at, review_summary) values
  ('11111111-1111-1111-1111-111111111111', 'https://github.com/alura/devreview/pull/142', 142, 'alura/devreview',  5, '2026-03-15T14:32:00Z', 'Exposição de variável de ambiente no bundle de produção detectada.'),
  ('11111111-1111-1111-1111-111111111111', 'https://github.com/alura/devreview/pull/139', 139, 'alura/devreview',  2, '2026-03-14T10:10:00Z', 'Lógica de negócio misturada com componente de UI.'),
  ('11111111-1111-1111-1111-111111111111', 'https://github.com/alura/platform/pull/137',  137, 'alura/platform',   0, '2026-03-13T09:00:00Z', 'Nenhum problema encontrado. PR aprovado sem ressalvas.'),
  ('11111111-1111-1111-1111-111111111111', 'https://github.com/alura/platform/pull/201',  201, 'alura/platform',   8, '2026-03-12T16:45:00Z', 'Múltiplas violações de arquitetura e padrões de nomenclatura.'),
  ('11111111-1111-1111-1111-111111111111', 'https://github.com/alura/mobile-app/pull/88',  88, 'alura/mobile-app', 1, '2026-03-11T11:20:00Z', 'Input sem validação adequada no formulário de cadastro.'),
  ('11111111-1111-1111-1111-111111111111', 'https://github.com/alura/mobile-app/pull/55',  55, 'alura/mobile-app', 3, '2026-03-10T08:05:00Z', 'Componentes sem uso de memo causando re-renders em lista.');

-- ADRs (Architecture Decision Records)
insert into adrs (team_id, title, context, decision, status, created_at) values
  ('11111111-1111-1111-1111-111111111111', 'Adoção de Redux Toolkit para gerenciamento de estado',       'O projeto cresceu e o estado local ficou difícil de manter entre múltiplas páginas. Avaliamos Context API, Zustand e Redux Toolkit.',                                                  'Usar Redux Toolkit como solução padrão de estado global, com slices organizados por domínio de negócio.',                                                  'accepted',   '2026-01-10T00:00:00Z'),
  ('11111111-1111-1111-1111-111111111111', 'Uso de TailwindCSS como framework de estilo',                'Avaliamos Styled Components, CSS Modules e Tailwind. Velocidade de desenvolvimento, consistência e tamanho do bundle foram os critérios principais.',                                    'Adotar TailwindCSS com tema escuro customizado baseado em gray-950, complementado por shadcn/ui para componentes de interface.',                            'accepted',   '2026-01-18T00:00:00Z'),
  ('11111111-1111-1111-1111-111111111111', 'Estratégia de cache para resultados de review',              'Reviews repetidos do mesmo PR geram custo desnecessário de tokens de LLM e aumentam o tempo de espera do usuário.',                                                                     'Proposta em discussão: usar hash do diff como chave de cache no Supabase por 24h, invalidando ao detectar novos commits.',                                 'proposed',   '2026-02-05T00:00:00Z'),
  ('11111111-1111-1111-1111-111111111111', 'Autenticação via JWT customizado',                           'Implementação inicial usava JWT próprio antes da integração com Supabase Auth. Gerava overhead de manutenção.',                                                                         'Substituído por Supabase Auth. Esta ADR está obsoleta e mantida apenas como registro histórico.',                                                          'deprecated', '2025-11-20T00:00:00Z'),
  ('11111111-1111-1111-1111-111111111111', 'Monorepo com npm workspaces',                                'Backend (MCP server) e frontend precisam compartilhar tipos TypeScript e evitar desincronização de interfaces.',                                                                         'Usar npm workspaces com packages separados: apps/web para frontend e apps/mcp-server para o servidor MCP customizado.',                                    'accepted',   '2026-02-22T00:00:00Z');
