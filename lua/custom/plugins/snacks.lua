local bufdelete = require("custom.snacks.bufdelete")
local dashboard = require("custom.snacks.dashboard")
local explorer = require("custom.snacks.explorer")
local image = require("custom.snacks.image")
local indent = require("custom.snacks.indent")
local lazygit = require("custom.snacks.lazygit")
local picker = require("custom.snacks.picker")
local zen = require("custom.snacks.zen")

local keys = {}
keys = vim.list_extend(keys, bufdelete.keys)
keys = vim.list_extend(keys, explorer.keys)
keys = vim.list_extend(keys, image.keys)
keys = vim.list_extend(keys, lazygit.keys)
keys = vim.list_extend(keys, picker.keys)
keys = vim.list_extend(keys, zen.keys)

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    styles = {
      relative = "cursor",
      border = "rounded",
      focusable = false,
      backdrop = false,
      row = 1,
      col = 1,
      -- width/height are automatically set by the image size unless specified below
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = dashboard.opts,
    explorer = explorer.opts,
    image = image.opts,
    indent = indent.opts, -- replace indent_line
    input = { enabled = true },
    lazygit = lazygit.opts,
    -- notifier = { enabled = true },  -- replace nvim-notify?
    picker = picker.opts,
    quickfile = { enabled = true },
    scroll = {
      enabled = true,
      -- animate = { duration = { step = 15, total = 250 }, easing = 'linear' }
    },
    -- statuscolumn = { enabled = true },  -- replace heirline?
    words = { enabled = true },
    zen = zen.opts,
  },
  keys = keys,
}
