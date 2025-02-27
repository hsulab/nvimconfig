return {
  opts = {
    enabled = true,
    doc = {
      -- enable image viewer for documents
      -- a treesitter parser must be available for the enabled languages.
      enabled = true,
      -- render the image inline in the buffer
      -- if your env doesn't support unicode placeholders, this will be disabled
      -- takes precedence over `opts.float` on supported terminals
      inline = false,
      -- render the image in a floating window
      -- only used if `opts.inline` is disabled
      float = false,
      max_width = 40,
      max_height = 20,
      -- Set to `true`, to conceal the image text when rendering inline.
      conceal = false, -- (experimental)
    },
    math = {
      enabled = false,
    },
  },
  keys = {
    {
      "<localleader>s",
      function()
        Snacks.image.hover()
      end,
      desc = "Render Image",
    },
  },
}
