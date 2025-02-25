return {
  "olimorris/codecompanion.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
      },
      adapters = {},
    })

    -- Set key for chat
    vim.api.nvim_set_keymap("n", "<localleader>c", "<cmd>CodeCompanionChat Toggle<cr>", { silent = true })

    -- Set key for completion
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true })
  end,
}
