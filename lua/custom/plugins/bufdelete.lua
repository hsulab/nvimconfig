return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<leader>c', '<cmd>Bdelete<cr>', { desc = 'Close the current buffer' })
  end,
}
