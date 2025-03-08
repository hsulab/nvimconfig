local M = {}

M.opts = {}

M.keys = {
  {
    "<leader>ff",
    function()
      Snacks.picker.files({
        layout = {
          layout = {
            box = "horizontal",
            -- backdrop = false,
            width = 0.9,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
              { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.6,
              border = "rounded",
              title_pos = "center",
            },
          },
        },
      })
    end,
    desc = "Find Files",
  },
}

return M
