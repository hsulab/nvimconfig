return {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    { "<leader>sc", "<esc><cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>ss", "<esc><cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/pictures" },
  },
  opts = {
    save_path = "~/Pictures/codesnap",
    has_breadcrumbs = false,
    -- bg_theme = "bamboo",
    bg_padding = 0,
  },
}
