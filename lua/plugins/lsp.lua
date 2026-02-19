-- Plugins de LSP e autocomplete para C, C++, C#, Lua e Python
-- Os servidores são instalados via Mason (:Mason) ou automaticamente
-- abaixo via mason-lspconfig ensure_installed.

return {
  

  -- Carrega as configs do lspconfig.lua
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      require "configs.lspconfig"
    end,
  },


  -- Auto-instalação dos LSPs via Mason
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "clangd",    -- C e C++
        "omnisharp", -- C#
        "lua_ls",    -- Lua
        "pyright",   -- Python
      },
      automatic_installation = false,
    },
  },

  -- Extensões para C/C++: inlay hints, switch header/source, hierarquia de tipos
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    config = function()
      require("clangd_extensions").setup {
        inlay_hints = {
          inline = true,
        },
      }
    end,
  },

  -- Suporte avançado de Lua para desenvolvimento de configs do Neovim
  -- (autocomplete de vim.*, vim.keymap, vim.api, etc.)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Tipos adicionais para vim.uv (usado pelo lazydev)
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },

  -- Adiciona source do lazydev ao nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "lazydev", group_index = 0 })
    end,
  },
}
