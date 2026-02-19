-- Plugins específicos para Rust

return {
  -- LSP completo para Rust (substitui o rust-analyzer padrão do lspconfig)
  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = false,
  },

  -- Formatação e comandos utilitários (:RustFmt, etc.)
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- Gerenciamento de dependências no Cargo.toml
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = { enabled = true },
        },
      }
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },
}
