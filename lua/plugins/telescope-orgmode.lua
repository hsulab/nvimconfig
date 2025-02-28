return {
  "nvim-orgmode/telescope-orgmode.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-orgmode/orgmode",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("orgmode")

    vim.keymap.set(
      "n",
      "<leader>for",
      require("telescope").extensions.orgmode.refile_heading,
      { desc = "[F]ind [O]rg [R]efile" }
    )
    vim.keymap.set(
      "n",
      "<leader>foh",
      require("telescope").extensions.orgmode.search_headings,
      { desc = "[F]ind [O]rg [H]eadings" }
    )
    -- vim.keymap.set("n", "<leader>foi", require("telescope").extensions.orgmode.insert_link)
  end,
}
