return {
  'stevearc/aerial.nvim',
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    vim.keymap.set('n', '<leader>lS', '<cmd>AerialToggle!<CR>', { desc = 'Symbol Outline' }),
  },
  config = function()
    require('aerial').setup { filter_kind = false }
  end,
}
