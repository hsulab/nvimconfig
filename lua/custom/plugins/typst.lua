return {
  "kaarmu/typst.vim",
  ft = { "typst" },
  init = function()
    vim.g.typst_pdf_viewer = "/Applications/sioyek.app"
  end,
  config = function()
    vim.api.nvim_set_keymap("n", "<localleader>ll", "<cmd>TypstWatch<cr>", { noremap = true, silent = true })
  end,
}
