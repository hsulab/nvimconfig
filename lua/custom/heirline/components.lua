local aerial = require("aerial")
local palette = require("catppuccin.palettes").get_palette("mocha")
local utils = require("heirline.utils")
local conditions = require("heirline.conditions")
local colors = {
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffDeleted").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}

---Get the names of all current listed buffers
---@return table
local function get_current_filenames()
  local listed_buffers = vim.tbl_filter(function(bufnr)
    return vim.bo[bufnr].buflisted and vim.api.nvim_buf_is_loaded(bufnr)
  end, vim.api.nvim_list_bufs())

  return vim.tbl_map(vim.api.nvim_buf_get_name, listed_buffers)
end

---Get unique name for the current buffer
---@param filename string
---@param shorten boolean
---@return string
local function get_unique_filename(filename, shorten)
  local filenames = vim.tbl_filter(function(filename_other)
    return filename_other ~= filename
  end, get_current_filenames())

  if shorten then
    filename = vim.fn.pathshorten(filename)
    filenames = vim.tbl_map(vim.fn.pathshorten, filenames)
  end

  -- Reverse filenames in order to compare their names
  filename = string.reverse(filename)
  filenames = vim.tbl_map(string.reverse, filenames)

  local index

  -- For every other filename, compare it with the name of the current file char-by-char to
  -- find the minimum index `i` where the i-th character is different for the two filenames
  -- After doing it for every filename, get the maximum value of `i`
  if next(filenames) then
    index = math.max(unpack(vim.tbl_map(function(filename_other)
      for i = 1, #filename do
        -- Compare i-th character of both names until they aren't equal
        if filename:sub(i, i) ~= filename_other:sub(i, i) then
          return i
        end
      end
      return 1
    end, filenames)))
  else
    index = 1
  end

  -- Iterate backwards (since filename is reversed) until a "/" is found
  -- in order to show a valid file path
  while index <= #filename do
    if filename:sub(index, index) == "/" then
      index = index - 1
      break
    end

    index = index + 1
  end

  return string.reverse(string.sub(filename, 1, index))
end

local M = {}
M.Spacer = { provider = " " }
M.Fill = { provider = "%=" }
M.Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%(%l:%c/%L%)(%P)",
}
M.ScrollBar = {
  static = {
    sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = palette.yellow, bg = palette.base },
}

-- Vim mode
M.ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = palette.blue,
      nt = palette.red,
      i = palette.green,
      v = palette.mauve,
      V = palette.mauve,
      ["\22"] = palette.mauve,
      c = palette.red,
      s = palette.pink,
      S = palette.pink,
      ["\19"] = palette.pink,
      R = palette.peach,
      r = palette.peach,
      ["!"] = palette.red,
      t = palette.green,
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    -- return '%1(' .. self.mode_names[self.mode] .. '%)'
    -- return ' %2(' .. self.mode_names[self.mode] .. '%)'
    return " "
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    -- local mode = self.mode:sub(1, 1) -- get only the first mode character
    -- return { fg = palette.base, bg = self.mode_colors[mode], bold = true }
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode], bold = true }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

M.MacroRecording = {
  condition = conditions.is_active,
  init = function(self)
    self.reg_recording = vim.fn.reg_recording()
    self.status_dict = vim.b.gitsigns_status_dict or { added = 0, removed = 0, changed = 0 }
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  {
    condition = function(self)
      return self.reg_recording ~= ""
    end,
    {
      provider = "󰻃 ",
      hl = { fg = palette.maroon },
    },
    {
      provider = function(self)
        return self.reg_recording
      end,
      hl = { fg = palette.maroon, italic = false, bold = true },
    },
    hl = { fg = palette.text, bg = palette.base },
  },
  update = { "RecordingEnter", "RecordingLeave" },
} -- MacroRecording

M.LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  provider = function()
    local names = {}
    ---@diagnostic disable-next-line: deprecated
    for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local name = server.name
      if server.name == "GitHub Copilot" then
        name = "copilot"
      end
      table.insert(names, name)
    end
    return table.concat(names, ",")
  end,
  hl = { fg = palette.maroon, bold = true },
}

M.ConformActive = {
  condition = function(self)
    local ok, conform = pcall(require, "conform")
    self.conform = conform
    return ok
  end,
  update = { "BufEnter" },
  provider = function(self)
    local formatters = self.conform.list_formatters_for_buffer(self.bufnr)
    return formatters and table.concat(formatters, ",") or "None"
  end,
  hl = { fg = palette.green, bold = true },
}

M.Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = palette.flamingo, bg = palette.base },

  { -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true, bg = palette.base },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
    hl = { bg = palette.base },
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = colors.git_add, bg = palette.base },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = colors.git_del, bg = palette.base },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = colors.git_change, bg = palette.base },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
    hl = { bg = palette.base },
  },
}

-- Diagnostics
M.Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = colors.diag_error },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = colors.diag_warn },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = colors.diag_info },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = colors.diag_hint },
  },
} -- Diagnostics

-- Spacing providers
M.RightPadding = function(child, num_space)
  local result = {
    condition = child.condition,
    child,
    M.Spacer,
  }
  if num_space ~= nil then
    for _ = 2, num_space do
      table.insert(result, M.Spacer)
    end
  end
  return result
end

-- File components
M.FileType = {
  provider = function()
    return vim.bo.filetype
  end,
  hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

M.FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
M.FileName = {
  provider = function(self)
    -- self.filename will be defined later, just keep looking at the example!
    local filename = self.filename
    filename = filename == "" and "[Untitiled]" or get_unique_filename(filename, false)
    return filename
  end,
  hl = function(self)
    return {
      fg = self.is_active and palette.text or palette.subtext0,
      bold = self.is_active or self.is_visible,
      italic = self.is_active,
    }
  end,
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
M.FilePath = {
  provider = function(self)
    -- first, trim the pattern relative to the current directory. For other
    -- options, see :h filename-modifers
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then
      return "[Untitiled]"
    end
    -- now, if the filename would occupy more than 1/4th of the available
    -- space, we trim the file path to its initials
    -- See Flexible Components section below for dynamic truncation
    -- if not conditions.width_percent_below(#filename, 0.25) then
    --   filename = vim.fn.pathshorten(filename, 4)
    -- end
    return filename
  end,
  hl = function(self)
    return {
      fg = self.is_active and palette.text or palette.subtext0,
      bold = self.is_active or self.is_visible,
      italic = self.is_active,
    }
  end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
M.FileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    provider = "",
    hl = function(self)
      return { fg = palette.text, bold = self.is_active }
    end,
  },
  {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
        or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
    end,
    provider = function(self)
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = self.bufnr })
      if buftype == "terminal" then
        return " "
      else
        return " "
      end
    end,
    hl = { fg = palette.text },
  },
}

M.FileNameBlock = {
  init = function(self)
    local bufnr = self.bufnr and self.bufnr or 0
    self.filename = vim.api.nvim_buf_get_name(bufnr)
  end,
  hl = { bg = palette.base, fg = palette.text },
  M.FileIcon,
  M.FileName,
  M.FileFlags,
}

M.FilePathBlock = {
  init = function(self)
    local bufnr = self.bufnr and self.bufnr or 0
    self.filename = vim.api.nvim_buf_get_name(bufnr)
  end,
  hl = { bg = palette.base, fg = palette.text },
  M.FileIcon,
  M.FilePath,
  M.FileFlags,
}

-- WinBar components
local function format_symbol_status(symbols, depth, separator, icons_enabled)
  local parts = {}
  depth = depth or #symbols

  if depth > 0 then
    symbols = { unpack(symbols, 1, depth) }
  else
    symbols = { unpack(symbols, #symbols + 1 + depth) }
  end

  for _, symbol in ipairs(symbols) do
    if icons_enabled then
      table.insert(parts, string.format("%s%s", symbol.icon, symbol.name))
    else
      table.insert(parts, symbol.name)
    end
  end

  return table.concat(parts, separator)
end

-- The API to output the symbols structure
local function output_symbols_structure(depth, separator, icons_enabled)
  local symbols = aerial.get_location(true)
  local symbols_structure = format_symbol_status(symbols, depth, separator, icons_enabled)
  return symbols_structure
end

M.AerialSymbols = {
  init = function(self) end,
  hl = { bg = palette.base, fg = palette.mauve, bold = true },
  provider = function(self)
    return output_symbols_structure(3, ">", true)
  end,
}

-- Tab components
M.TablineFileNameBlock = vim.tbl_extend("force", M.FileNameBlock, {
  on_click = {
    callback = function(_, minwid, _, button)
      if button == "m" then -- close on mouse middle click
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
})

vim.opt.showcmdloc = "statusline"
M.ShowCmd = {
  condition = function()
    return vim.o.cmdheight == 0
  end,
  provider = "%3.5(%S%)",
}
return M
