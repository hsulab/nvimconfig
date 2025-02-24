return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = "BufEnter *.md",
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    latex = {
      -- Whether LaTeX should be rendered, mainly used for health check
      enabled = true,
      -- Additional modes to render LaTeX
      render_modes = false,
      -- Executable used to convert latex formula to rendered unicode
      converter = "latex2text",
      -- Highlight for LaTeX blocks
      highlight = "RenderMarkdownMath",
      -- Amount of empty lines above LaTeX blocks
      top_pad = 0,
      -- Amount of empty lines below LaTeX blocks
      bottom_pad = 0,
    },
  },
}
