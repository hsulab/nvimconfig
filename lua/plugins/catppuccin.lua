return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  "catppuccin/nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    require("catppuccin").setup({
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
    })
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles:
    vim.cmd.colorscheme("catppuccin-mocha")

    -- You can configure highlights by doing something like:
    vim.cmd.hi("Comment gui=none")
  end,
}
-- vim: ts=2 sts=2 sw=2 et
