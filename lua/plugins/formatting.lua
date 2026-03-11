-- Formatação via conform.nvim
-- Igual ao seu NvChad: formata ao salvar com os mesmos formatters

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Lua
        lua = { "stylua" },
        -- C e C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- Rust (backup; rustaceanvim já formata via LSP)
        rust = { "rustfmt" },
        -- Python: tenta ruff primeiro, cai no black se não instalado
        python = { "ruff_format", "black" },
        -- Web
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      -- Formata ao salvar (500ms de timeout)
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },
}
