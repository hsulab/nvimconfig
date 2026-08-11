return {
  "https://github.com/IogaMaster/tuxedo.nvim.git",
  keys = {
    { "<localleader>t", "<cmd>Tuxedo<cr>", desc = "Toggle Tuxedo" },
  },
  config = function(_, opts)
    require("tuxedo").setup({
      create_todo_file = true,
      width_ratio = 0.95,
      height_ratio = 0.80,
    })
  end,
}
