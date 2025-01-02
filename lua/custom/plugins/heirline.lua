return {
  'rebelot/heirline.nvim',
  events = 'VeryLazy',
  config = function()
    vim.opt.cmdheight = 0
    local conditions = require 'heirline.conditions'
    require('heirline').setup {
      statusline = require 'custom.heirline.statusline',
      tabline = require 'custom.heirline.tabline',
      winbar = require 'custom.heirline.winbar',
      opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
          return conditions.buffer_matches({
            buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
            filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard', 'lazygit' },
          }, args.buf)
        end,
      },
    }
  end,
}
