local M = {}

M.opts = {
  layout = {
    cycle = true,
    --- Use the default layout or vertical if the window is too narrow
    preset = function()
      return vim.o.columns >= 120 and "default" or "vertical"
    end,
    layout = {
      width = 0.9,
      height = 0.9,
    },
  },
}

M.keys = {
  {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find Files",
  },
  {
    "<leader>fw",
    function()
      Snacks.picker.grep()
    end,
    desc = "Find Words",
  },
  {
    "<leader>fW",
    function()
      Snacks.picker.grep_word()
    end,
    desc = "Find Word",
  },
  {
    "<leader>fd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Diagnostics",
  },
  {
    "<leader>fD",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = "Buffer Diagnostics",
  },
  {
    "<leader>fb",
    function()
      Snacks.picker.lines()
    end,
    desc = "Buffer Lines",
  },
  {
    "<leader>fB",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Grep Open Buffers",
  },
  {
    "<leader>fn",
    function()
      Snacks.picker.notifications()
    end,
    desc = "Notification History",
  },
  {
    "<leader>fk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Keymaps",
  },
  -- LSP
  {
    "gd",
    function()
      Snacks.picker.lsp_definitions()
    end,
    desc = "Goto Definition",
  },
  {
    "gD",
    function()
      Snacks.picker.lsp_declarations()
    end,
    desc = "Goto Declaration",
  },
  {
    "gr",
    function()
      Snacks.picker.lsp_references()
    end,
    nowait = true,
    desc = "References",
  },
  {
    "gI",
    function()
      Snacks.picker.lsp_implementations()
    end,
    desc = "Goto Implementation",
  },
  {
    "gy",
    function()
      Snacks.picker.lsp_type_definitions()
    end,
    desc = "Goto T[y]pe Definition",
  },
  {
    "<leader>ls",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "LSP Symbols",
  },
}

return M
