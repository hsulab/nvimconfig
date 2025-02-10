return {
  keys = {
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Close the current buffer",
    },
    {
      "<leader>C",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Close all buffers except for the current",
    },
  },
}
