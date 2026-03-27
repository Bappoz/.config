local themes = {
  "tokyonight",
  "catppuccin",
  "gruvbox",
  "kanagawa",
  "rose-pine",
  "everforest",
  "monokai-pro",
  "nord",
}

local function apply_transparency()
  local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"
  if vim.fn.filereadable(transparency_file) == 1 then
    vim.cmd.source(transparency_file)
  end
end

local function set_colorscheme(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.api.nvim_echo({ { "Tema nao encontrado: " .. name, "ErrorMsg" } }, false, {})
    return
  end
  apply_transparency()
end

local function theme_pick()
  vim.ui.select(themes, { prompt = "Escolha um tema" }, function(choice)
    if not choice then
      return
    end
    set_colorscheme(choice)
  end)
end

local function theme_next()
  local current = vim.g.current_theme_name
  local idx = 1
  for i, name in ipairs(themes) do
    if name == current then
      idx = i
      break
    end
  end
  local next_name = themes[(idx % #themes) + 1]
  vim.g.current_theme_name = next_name
  set_colorscheme(next_name)
end

return {
  {
    "LazyVim/LazyVim",
    opts = {},
    config = function()
      if not vim.g.current_theme_name then
        vim.g.current_theme_name = themes[1]
      end

      vim.api.nvim_create_user_command("ThemePick", theme_pick, { desc = "Escolher tema de cores" })
      vim.api.nvim_create_user_command("ThemeNext", theme_next, { desc = "Ir para o proximo tema" })

      vim.api.nvim_create_user_command("BackgroundDark", function()
        vim.o.background = "dark"
        apply_transparency()
      end, { desc = "Fundo escuro" })

      vim.api.nvim_create_user_command("BackgroundLight", function()
        vim.o.background = "light"
        apply_transparency()
      end, { desc = "Fundo claro" })

      vim.api.nvim_create_user_command("BackgroundToggle", function()
        vim.o.background = (vim.o.background == "dark") and "light" or "dark"
        apply_transparency()
      end, { desc = "Alternar fundo claro/escuro" })
    end,
  },
}
