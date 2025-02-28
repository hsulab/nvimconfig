-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  opts = {
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = "<Up> ",
        Down = "<Down> ",
        Left = "<Left> ",
        Right = "<Right> ",
        C = "<C-…> ",
        M = "<M-…> ",
        D = "<D-…> ",
        S = "<S-…> ",
        CR = "<CR> ",
        Esc = "<Esc> ",
        ScrollWheelDown = "<ScrollWheelDown> ",
        ScrollWheelUp = "<ScrollWheelUp> ",
        NL = "<NL> ",
        BS = "<BS> ",
        Space = "<Space> ",
        Tab = "<Tab> ",
        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },
  },
  config = function()
    require("which-key").setup({
      ---@param ctx { mode: string, operator: string }
      defer = function(ctx)
        if vim.list_contains({ "d", "y" }, ctx.operator) then
          return true
        end
        return vim.list_contains({ "v", "<C-V>", "V" }, ctx.mode)
      end,
      preset = "helix",
    })
    -- Document existing key chains
    require("which-key").add({
      { "<leader>c", group = "Close Buffer", hidden = true },
      { "<leader>C", group = "Close Buffer", hidden = true },
      { "<leader>e", group = "Explorer", hidden = true },
      { "<leader>f", group = "Find", mode = "n" },
      { "<leader>g", group = "Git", mode = { "n", "v" } },
      { "<leader>l", group = "Lsp", mode = "n", icon = "󰿘 " },
      -- { "<leader>o", group = "Oil", hidden = true },
      { "<leader>p", group = "Package", mode = "n", icon = " " },
      { "<leader>q", group = "Quit", mode = "n", hidden = true },
      { "<leader>r", group = "Overseer", mode = "n", icon = "󰑮 " },
      { "<leader>s", group = "Session", mode = "n" },
      { "<leader>t", group = "Terminal", mode = "n" },
      { "<leader>z", group = "Zen Mode", hidden = true },
      { "<leader>Z", group = "Zen Mode", hidden = true },
      { "<leader>/", group = "Comment", hidden = true },
      { "<localleader>l", group = "Latex", icon = " " },
    })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
