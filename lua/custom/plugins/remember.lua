return {
  'vladdoster/remember.nvim',
  config = function()
    require('remember').setup {
      -- for example, open_folds is off by default, use this to turn it on
      open_folds = true,
    }
  end,
}
