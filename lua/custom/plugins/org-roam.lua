return {
  "chipsenkbeil/org-roam.nvim",
  event = "BufEnter *.org",
  ft = { "org" },
  lazy = true,
  tag = "0.1.1",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
    },
  },
  config = function()
    require("org-roam").setup({
      directory = "~/Documents/orgfiles",
    })
  end,
}
