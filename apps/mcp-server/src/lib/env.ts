import { fileURLToPath } from "node:url";

// Resolvido a partir deste arquivo (build/lib/env.js -> apps/mcp-server/.env),
// e não do cwd: o Claude Code sobe o server da raiz do repo e o Inspector de apps/mcp-server.
const ENV_PATH = fileURLToPath(new URL("../../.env", import.meta.url));

/**
 * Carrega apps/mcp-server/.env, se existir. Variáveis já definidas no ambiente
 * têm precedência. Sem o arquivo, o server sobe normalmente (tools mock não dependem dele).
 */
export function loadEnv(): void {
  try {
    process.loadEnvFile(ENV_PATH);
  } catch (error: unknown) {
    if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;
  }
}
