local dashboard = require("custom.snacks.dashboard")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = dashboard,
    indent = { enabled = true }, -- replace indent_line
    input = { enabled = true },
    -- notifier = { enabled = true },  -- replace nvim-notify?
    quickfile = { enabled = true },
    scroll = {
      enabled = true,
      -- animate = { duration = { step = 15, total = 250 }, easing = 'linear' }
    },
    -- statuscolumn = { enabled = true },  -- replace heirline?
    words = { enabled = true },
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
