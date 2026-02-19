-- Plugins base: formatação
-- Os demais plugins ficam em arquivos separados:
--   plugins/rust.lua    → Rust
--   plugins/copilot.lua → Copilot + CopilotChat
--   plugins/lsp.lua     → LSP extra (C, C++, C#, Lua, Python)

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
}
