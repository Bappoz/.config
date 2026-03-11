-- LSP para C, C++, Lua e Python
-- Usa os extras oficiais do LazyVim + extensões adicionais

return {
  -- ─── Servidores LSP via Mason ─────────────────────────────────────────────
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd", -- C e C++
        "lua-language-server", -- Lua
        "pyright", -- Python
        -- formatters
        "stylua",
        "clang-format",
        "black",
        "ruff",
      },
    },
  },

  -- ─── Configuração dos servidores ─────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Lua: reconhece vim.*, vim.api, keymaps, etc.
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },

        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- C e C++ (clangd já vem pelo extra,
        -- mas aqui customizamos os args)
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders=1",
          },
        },
      },
      -- Diagnósticos: float arredondado, sem update em insert mode
      diagnostics = {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          focusable = false,
        },
      },
    },
  },

  -- ─── Extensões para C/C++ ─────────────────────────────────────────────────
  -- Inlay hints, switch header/source, hierarquia de tipos
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = { inline = true },
      })
    end,
  },

  -- ─── Suporte avançado de Lua para configs do Neovim ───────────────────────
  -- Autocomplete de vim.*, vim.keymap, vim.api, etc.
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Tipos de vim.uv (usado pelo lazydev)
  { "Bilal2453/luvit-meta", lazy = true },

  -- Adiciona source do lazydev ao blink.cmp
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
