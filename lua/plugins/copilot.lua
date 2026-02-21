-- Plugins de IA: Copilot e CopilotChat

return {
  -- Sugestões inline do Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = false,
          keymap = {
            accept = "<C-l>",
          },
        },
      }
      -- Log Copilot Desabilitado
      vim.cmd("Copilot disable")
    end,
  },

  -- Chat interativo com o Copilot
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Abrir Chat do Copilot" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explicar Código" },
      { "<leader>cr", "<cmd>CopilotChatRewrite<cr>", desc = "Reescrever Código" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Corrigir Código" },
    },
  },
}
