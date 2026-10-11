import {
  BACKEND_TEAM_ID,
  INTEGRATIONS_TEAM_ID,
  TEAM_ID,
} from "../lib/team.js";
import type { Team } from "../types.js";

/** Times de `supabase/seed.sql`, na mesma ordem. */
export const mockTeams: readonly Team[] = [
  { id: TEAM_ID, name: "Frontend" },
  { id: BACKEND_TEAM_ID, name: "Backend" },
  { id: INTEGRATIONS_TEAM_ID, name: "Integrations" },
];
