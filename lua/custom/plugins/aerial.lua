return {
  "stevearc/aerial.nvim",
  -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  event = "VeryLazy",
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    vim.keymap.set("n", "<leader>lS", "<cmd>AerialToggle!<CR>", { desc = "Symbol Outline" }),
  },
  config = function()
    require("aerial").setup({ filter_kind = false, icons = { Variable = "󰫧 " } })
  end,
}
