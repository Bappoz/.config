-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Mostra float de diagnósticos ao parar o cursor
vim.o.updatetime = 250
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = "rounded",
      source = "always",   -- mostra de qual LSP/linter veio o erro
      scope = "cursor",    -- só o diagnóstico sob o cursor
      header = "",
      prefix = " ",
      format = function(diagnostic)
        local msg = diagnostic.message
        if diagnostic.code then
          msg = msg .. " [" .. diagnostic.code .. "]"
        end
        return msg
      end,
    })
  end,
})
