return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        version = "v2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    opts = {
      window = {
        mappings = {
          -- abre o arquivo e mantém o cursor no neo-tree
          ["<cr>"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              require("neo-tree.sources.filesystem.commands").toggle_node(state)
            else
              require("neo-tree.sources.common.commands").open(state)
              vim.cmd("wincmd p")
            end
          end,
          -- para ir ao arquivo e fechar o neo-tree
          ["o"] = "open_with_window_picker",
          ["S"] = "split_with_window_picker",
          ["s"] = "vsplit_with_window_picker",
        },
      },
    },
  },
}
