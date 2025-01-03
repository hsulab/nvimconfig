local components = require("custom.heirline.components")

return { -- statusline
  components.RightPadding(components.ViMode, 2),
  components.RightPadding(components.Git, 4),
  components.RightPadding(components.FilePathBlock, 2),
  components.RightPadding(components.Diagnostics),
  components.Fill,
  components.MacroRecording,
  components.Fill,
  components.RightPadding(components.ShowCmd),
  components.Fill,
  components.RightPadding(components.CodeCompanion),
  components.RightPadding(components.ConformActive),
  components.RightPadding(components.LSPActive),
  components.RightPadding(components.FileType, 0),
  components.RightPadding(components.Ruler),
  components.ScrollBar,
}
