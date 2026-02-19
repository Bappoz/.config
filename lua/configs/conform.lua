local options = {
  formatters_by_ft = {
    -- Web
    css        = { "prettier" },
    html       = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    -- Scripting / Config
    lua        = { "stylua" },
    -- Systems
    c          = { "clang_format" },
    cpp        = { "clang_format" },
    cs         = { "csharpier" },
    rust       = { "rustfmt" },
    -- Python
    python     = { "ruff_format", "black" }, -- tenta ruff; cai no black se não instalado
  },

  -- Formata ao salvar
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

