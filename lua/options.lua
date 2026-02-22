require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


vim.api.nvim_set_hl(0, "DiagnosticFloat", {
  bg = "#1e1e2e",  -- cor de fundo
  fg = "#cdd6f4",  -- cor do texto
})

vim.api.nvim_set_hl(0, "DiagnosticFloatBorder", {
  bg = "#1e1e2e",
  fg = "#89b4fa",  -- cor da borda
})
