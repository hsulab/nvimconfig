local dashboard = require("custom.snacks.dashboard")
local indent = require("custom.snacks.indent")

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
    indent = indent, -- replace indent_line
    input = { enabled = true },
    -- notifier = { enabled = true },  -- replace nvim-notify?
    quickfile = { enabled = true },
    scroll = {
      enabled = true,
      -- animate = { duration = { step = 15, total = 250 }, easing = 'linear' }
    },
    -- statuscolumn = { enabled = true },  -- replace heirline?
    words = { enabled = true },
    zen = {
      toggles = {
        dim = false,
        git_signs = false,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
    },
  },
  keys = {
    -- bufdelete
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>C",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete Buffer",
    },
    -- zen
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
