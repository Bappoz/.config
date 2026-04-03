local themes = {
  -- dark & moody
  "tokyonight",
  "tokyonight-night",
  "tokyonight-storm",
  "tokyonight-moon",
  "kanagawa",
  "kanagawa-wave",
  "kanagawa-dragon",
  "catppuccin",
  "catppuccin-mocha",
  "catppuccin-macchiato",
  "catppuccin-frappe",
  "catppuccin-latte",
  "rose-pine",
  "rose-pine-moon",
  "rose-pine-dawn",
  -- classic
  "gruvbox",
  "everforest",
  "nord",
  "onedark",
  -- high contrast / unique
  "monokai-pro",
  "dracula",
  "oxocarbon",
  "cyberdream",
  "eldritch",
  -- nightfox family
  "nightfox",
  "nordfox",
  "terafox",
  "carbonfox",
  "dawnfox",
  "dayfox",
  -- vscode-like
  "vscode",
  -- minimal / niche
  "bamboo",
  "flexoki-neovim",
  "matteblack",
  "aether",
  "ethereal",
  "hackerman",
  "ansi",
}

local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

local function save_theme(name, bg)
  local f = io.open(theme_file, "w")
  if f then
    f:write(name .. "\n" .. (bg or vim.o.background) .. "\n")
    f:close()
  end
end

local function get_saved_theme()
  local f = io.open(theme_file, "r")
  if f then
    local name = f:read("*l")
    local bg = f:read("*l")
    f:close()
    return name, bg
  end
  return nil, nil
end

local function apply_transparency()
  local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"
  if vim.fn.filereadable(transparency_file) == 1 then
    vim.cmd.source(transparency_file)
  end
end

local function set_colorscheme(name, dont_save)
  local ok = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.api.nvim_echo({ { "Tema nao encontrado: " .. name, "ErrorMsg" } }, false, {})
    return
  end
  vim.g.current_theme_name = name
  if not dont_save then
    save_theme(name, vim.o.background)
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
  set_colorscheme(next_name)
end

return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local name, bg = get_saved_theme()
      if name and name ~= "" then
        opts.colorscheme = name
      end
    end,
    config = function(_, opts)
      -- Define o background ANTES do setup aplicar o colorscheme
      local name, bg = get_saved_theme()
      if name and name ~= "" then
        vim.g.current_theme_name = name
        if bg and bg ~= "" then
          vim.o.background = bg
        end
      else
        vim.g.current_theme_name = themes[1]
      end

      -- OBRIGATÓRIO: chama o setup do LazyVim (carrega keymaps, autocmds,
      -- registra :LazyExtras, aplica colorscheme, etc.)
      require("lazyvim").setup(opts)

      -- Aplica transparência logo após o colorscheme ser definido pelo setup
      apply_transparency()

      -- Re-aplica transparência sempre que o colorscheme mudar
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = apply_transparency,
      })

      vim.api.nvim_create_user_command("ThemePick", theme_pick, { desc = "Escolher tema de cores" })
      vim.api.nvim_create_user_command("ThemeNext", theme_next, { desc = "Ir para o proximo tema" })

      vim.api.nvim_create_user_command("BackgroundDark", function()
        vim.o.background = "dark"
        save_theme(vim.g.current_theme_name or vim.g.colors_name, "dark")
        apply_transparency()
      end, { desc = "Fundo escuro" })

      vim.api.nvim_create_user_command("BackgroundLight", function()
        vim.o.background = "light"
        save_theme(vim.g.current_theme_name or vim.g.colors_name, "light")
        apply_transparency()
      end, { desc = "Fundo claro" })

      vim.api.nvim_create_user_command("BackgroundToggle", function()
        local new_bg = (vim.o.background == "dark") and "light" or "dark"
        vim.o.background = new_bg
        save_theme(vim.g.current_theme_name or vim.g.colors_name, new_bg)
        apply_transparency()
      end, { desc = "Alternar fundo claro/escuro" })
    end,
  },
}
