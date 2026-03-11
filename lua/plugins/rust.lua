-- Plugins específicos para Rust
-- Usa o extra oficial do LazyVim + plugins adicionais

return {
  -- ─── Formatação automática ao salvar ─────────────────────────────────────
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- ─── Gerenciamento de dependências no Cargo.toml ──────────────────────────
  -- Mostra versões, permite update/add de crates inline
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({})
    end,
  },
}
