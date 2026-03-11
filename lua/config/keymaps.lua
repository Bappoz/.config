-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ; como atalho para entrar no modo de comando (igual ao NvChad)
map("n", ";", ":", { desc = "CMD enter command mode" })

-- jk no modo insert para voltar ao normal (saída rápida)
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Ctrl+S para salvar em qualquer modo
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Navegação entre splits (estilo NvChad, já presentes no LazyVim mas explicitado aqui)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Redimensionar splits
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Navegar entre buffers com Tab / Shift+Tab
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

-- Mover linhas selecionadas (modo visual) para cima/baixo
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Manter cursor no centro ao rolar com Ctrl+d / Ctrl+u
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })

-- Mover a linha atual para baixo (Alt + Seta Baixo)
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
-- Mover a linha atual para cima (Alt + Seta Cima)
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true })

-- Mover blocos selecionados no Modo Visual
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })

-- Alt+i: mini terminal flutuante (toggle)
map({ "n", "i", "t" }, "<A-i>", function()
  Snacks.terminal.toggle(nil, {
    win = {
      style = "float",
      height = 0.6,
      width = 0.6,
      border = "rounded",
      title = " Terminal ",
      title_pos = "center",
    },
  })
end, { desc = "Toggle floating terminal" })
