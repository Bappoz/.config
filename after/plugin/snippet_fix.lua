-- Workaround: nvim 0.12.x bug where vim.snippet crashes in CursorMovedI
-- when a tabstop's extmark is deleted (e.g. by LSP/formatter buffer edits).
-- get_extmark_range returns {} for missing marks, then mark[3].end_row crashes.
local orig_expand = vim.snippet.expand
vim.snippet.expand = function(input)
  orig_expand(input)
  local session = vim.snippet._session
  if not session then return end
  for _, tabstops in pairs(session.tabstops) do
    for _, ts in ipairs(tabstops) do
      local orig_get_range = ts.get_range
      ts.get_range = function(self)
        local ok, result = pcall(orig_get_range, self)
        if not ok then
          vim.snippet.stop()
          return { 0, 0, 0, 0 }
        end
        return result
      end
    end
  end
end
