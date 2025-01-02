return {
  'stevearc/resession.nvim',
  opts = {},
  config = function()
    local resession = require 'resession'
    resession.setup {}

    -- [[ Plugin Keymaps ]]
    -- Resession does NOTHING automagically, so we have to set up some keymaps
    vim.keymap.set('n', '<leader>ss', resession.save, { desc = '[S]ession save' })
    vim.keymap.set('n', '<leader>sl', resession.load, { desc = '[S]ession load' })
    vim.keymap.set('n', '<leader>sd', resession.delete, { desc = '[S]ession delete' })

    -- Automatically save sessions on by working directory on exit
    -- vim.api.nvim_create_autocmd('VimLeavePre', {
    --   callback = function()
    --     resession.save(vim.fn.getcwd(), { notify = true })
    --   end,
    -- })

    -- Automatically load sessions on startup by working directory
    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   callback = function()
    --     -- Only load the session if nvim was started with no args
    --     if vim.fn.argc(-1) == 0 then
    --       resession.load(vim.fn.getcwd(), { silence_errors = true })
    --     end
    --   end,
    --   nested = true,
    -- })
  end,
}
