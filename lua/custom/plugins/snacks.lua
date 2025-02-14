local bufdelete = require("custom.snacks.bufdelete")
local dashboard = require("custom.snacks.dashboard")
local indent = require("custom.snacks.indent")
local zen = require("custom.snacks.zen")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = dashboard.opts,
    indent = indent.opts, -- replace indent_line
    input = { enabled = true },
    -- notifier = { enabled = true },  -- replace nvim-notify?
    quickfile = { enabled = true },
    scroll = {
      enabled = true,
      -- animate = { duration = { step = 15, total = 250 }, easing = 'linear' }
    },
    -- statuscolumn = { enabled = true },  -- replace heirline?
    words = { enabled = true },
    zen = zen.opts,
  },
  keys = vim.list_extend(zen.keys, bufdelete.keys),
}
