return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    open_cmd = 'qutebrowser "%s"', -- command to open the preview window
    dependencies_bin = {
      ["tinymist"] = "tinymist",
    },
  }, -- lazy.nvim will implicitly calls `setup {}`
  keys = {
    {
      "<localleader>ll",
      "<cmd>TypstPreview<cr>",
      desc = "Toggle Typst Preview",
    },
  },
}
