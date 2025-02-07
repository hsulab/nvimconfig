return {
  enabled = true,
  chunk = {
    -- when enabled, scopes will be rendered as chunks, except for the
    -- top-level scope which will be rendered as a scope.
    enabled = true,
    -- only show chunk scopes in the current window
    only_current = false,
    priority = 200,
    hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
    char = {
      -- corner_top = "┌",
      -- corner_bottom = "└",
      corner_top = "╭",
      corner_bottom = "╰",
      horizontal = "─",
      vertical = "│",
      arrow = ">",
    },
  },
}
