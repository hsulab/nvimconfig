return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({ default_file_explorer = false })
    -- vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "Open current directory in Oil" })
  end,
}
