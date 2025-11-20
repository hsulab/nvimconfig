return {
  "github/copilot.vim",
  config = function()
    -- Set key for completion
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true })
  end,
}
