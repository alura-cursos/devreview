import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { mockReviewRules } from "../mocks/review-rules.js";
import { mockTeams } from "../mocks/teams.js";
import { RULE_CATEGORIES, RULE_SEVERITIES } from "../types.js";

export function registerGetTeamReviewRules(server: McpServer): void {
  server.registerTool(
    "get_team_review_rules",
    {
      title: "Listar regras de code review por time",
      description:
        "Retorna as regras de code review agrupadas por time, com filtros " +
        "opcionais por categoria, severidade e status. Se team_id for " +
        "informado, retorna apenas o time correspondente. Os dados são " +
        "mockados a partir do seed do Supabase (supabase/seed.sql).",
      inputSchema: {
        team_id: z
          .string()
          .uuid()
          .optional()
          .describe("ID do time; se omitido, retorna todos os times"),
        category: z
          .enum(RULE_CATEGORIES)
          .optional()
          .describe("Filtra pela categoria da regra"),
        severity: z
          .enum(RULE_SEVERITIES)
          .optional()
          .describe("Filtra pela severidade da regra"),
        active_only: z
          .boolean()
          .default(true)
          .describe("Se true, retorna apenas regras ativas"),
      },
    },
    async ({ team_id, category, severity, active_only }) => {
      const teams = team_id
        ? mockTeams.filter((t) => t.id === team_id)
        : mockTeams;

      if (team_id && teams.length === 0) {
        return {
          isError: true,
          content: [
            { type: "text", text: `Time não encontrado: ${team_id}` },
          ],
        };
      }

      const grouped = teams.map((team) => {
        const rules = mockReviewRules
          .filter(
            (r) =>
              r.team_id === team.id &&
              (!category || r.category === category) &&
              (!severity || r.severity === severity) &&
              (!active_only || r.active)
          )
          .map(({ team_id: _teamId, ...rule }) => rule);

        return {
          team_id: team.id,
          team_name: team.name,
          total: rules.length,
          rules,
        };
      });

      const text = JSON.stringify(
        { total_teams: grouped.length, teams: grouped },
        null,
        2
      );
      return { content: [{ type: "text", text }] };
    }
  );
}
