return {
  {
    "smoka7/hop.nvim",
    event = "BufEnter",
    version = "*",
    opts = {},
    keys = {
      {
        "W",
        "<cmd>HopWord<cr>",
        desc = "Hop to Word",
        silent = true,
      },
      {
        "E",
        "<cmd>HopLine<cr>",
        desc = "Hop to Line",
        silent = true,
      },
    },
  },
}
