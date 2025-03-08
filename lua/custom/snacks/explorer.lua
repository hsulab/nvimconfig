local M = {}

M.opts = {
  enabled = true,
  replace_netrw = true,
}

M.keys = {
  {
    "<leader>e",
    function()
      Snacks.explorer()
    end,
    desc = "File Explorer",
  },
}

return M
