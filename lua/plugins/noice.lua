-- Fix: noice.nvim treesitter query error ao entrar no modo command
-- Desabilita o uso do parser "vim" no cmdline para evitar o crash

return {
	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				format = {
					-- Remove lang = "vim" para não usar treesitter no cmdline
					cmdline = { pattern = "^:", icon = "" },
					search_down = { kind = "search", pattern = "^/", icon = " " },
					search_up = { kind = "search", pattern = "^%?", icon = " " },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = {
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
						icon = "",
						lang = "lua",
					},
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				},
			},
		},
	},
}
