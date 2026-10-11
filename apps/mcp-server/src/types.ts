// Espelha apps/web/src/types/index.ts e o check constraint de
// supabase/migrations/00001_init_schema.sql; mantenha em sincronia.

export const RULE_CATEGORIES = [
  "style",
  "architecture",
  "security",
  "performance",
] as const;

export const RULE_SEVERITIES = ["error", "warning", "info"] as const;

export type RuleCategory = (typeof RULE_CATEGORIES)[number];
export type RuleSeverity = (typeof RULE_SEVERITIES)[number];

export interface Team {
  id: string;
  name: string;
}

export interface ReviewRule {
  id: string;
  team_id: string;
  category: RuleCategory;
  rule: string;
  severity: RuleSeverity;
  active: boolean;
}
