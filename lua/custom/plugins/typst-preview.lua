return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    -- open_cmd = 'qutebrowser "%s"', -- command to open the preview window
    -- open_cmd = 'open -a Safari "%s"',
    open_cmd = 'open -a Firefox "%s"',
    -- open_cmd = '/Applications/Firefox.app/Contents/MacOS/firefox %s -P typst-preview --class typst-preview',
    dependencies_bin = {
      ["tinymist"] = "tinymist",
    },
  }, -- lazy.nvim will implicitly calls `setup {}`
  keys = {
  },
  config = function (_, opts)
    require("typst-preview").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "typst",
      callback = function ()
        vim.keymap.set(
          "n",
          "<localleader>ll",
          "<cmd>TypstPreview<cr>",
          { desc = "Toggle Typst Preview" }
        )
      end,
    })
  end,
}
