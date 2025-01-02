return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    }

    vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = '[T]oggleTerm [F]loat' })
    vim.api.nvim_set_keymap('n', '<leader>th', '<cmd>ToggleTerm size=20 direction=horizontal<cr>', { desc = '[T]oggleTerm [H]orizontal' })
    vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = '[T]oggleTerm [V]ertical' })
    vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>ToggleTerm direction=tab<cr>', { desc = '[T]oggleTerm [T]ab' })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd 'autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()'
  end,
}
