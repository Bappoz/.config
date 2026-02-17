return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!

  -- Rustaceanvim (LSP e Debug para Rust)
  {
    'mrcjkb/rustaceanvim',
    version = '^8', -- Versão estável para evitar erros de sintaxe no WSL
    lazy = false,
  },

  -- 4. Suporte básico e auto-format para Rust
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- 5. Gerenciamento de Crates (Cargo.toml)
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = { enabled = true },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },


  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>", -- Use Ctrl + l para aceitar a sugestão
          },
        },
      })
    end,
  },




  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Opcional, ajuda na performance
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Abrir Chat do Copilot" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explicar Código" },
      { "<leader>cr", "<cmd>CopilotChatRewrite<cr>", desc = "Reescrever Código"},
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Corrigir Código" },
    },
  },




  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
