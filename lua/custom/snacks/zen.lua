return {
  opts = {
    toggles = {
      dim = false,
      git_signs = false,
      mini_diff_signs = false,
      -- diagnostics = false,
      -- inlay_hints = false,
    },
  },
  keys = {
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
  },
}
