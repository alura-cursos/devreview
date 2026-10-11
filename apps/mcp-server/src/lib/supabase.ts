import { createClient, type SupabaseClient } from "@supabase/supabase-js";

// Ainda não usado por nenhuma tool: ponto de integração para o Módulo 4.

let client: SupabaseClient | null = null;

/**
 * Cliente Supabase lazy: o servidor sobe sem variáveis de ambiente
 * e só exige SUPABASE_URL/SUPABASE_SERVICE_KEY quando o cliente é usado.
 */
export function getSupabase(): SupabaseClient {
  const supabaseUrl = process.env.SUPABASE_URL;
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY;

  if (!supabaseUrl || !supabaseServiceKey) {
    throw new Error(
      "SUPABASE_URL e SUPABASE_SERVICE_KEY são obrigatórios. " +
        "Use os valores de apps/mcp-server/.env.example com o Supabase local."
    );
  }

  client ??= createClient(supabaseUrl, supabaseServiceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
  return client;
}
