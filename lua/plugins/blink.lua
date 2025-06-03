return {
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  -- event = { "BufReadPost", "BufNewFile" },
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saghen/blink.compat",
    { "micangl/cmp-vimtex", event = "InsertEnter", ft = "tex" },
  },

  -- use a release tag to download pre-built binaries
  version = "0.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = "none",
      ["<CR>"] = { "accept", "fallback" },

      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<Right>"] = { "snippet_forward", "fallback" },
      ["<Left>"] = { "snippet_backward", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    cmdline = {
      enabled = true,
      keymap = {
        preset = "none",
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_and_accept()
            else
              return cmp.show()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            else
              return cmp.show()
            end
          end,
          "fallback",
        },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = false,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = false,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = false },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = {
          -- Whether to auto-insert brackets for functions
          enabled = true,
          -- Default brackets to use for unknown languages
          default_brackets = { "(", ")" },
          -- Overrides the default blocked filetypes
          override_brackets_for_filetypes = {},
        },
      },
      list = {
        cycle = {
          from_bottom = true,
        },
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        draw = {
          treesitter = { "lsp" },
        },
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        auto_show = true,
        window = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          border = "rounded",
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        border = "rounded",
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "codecompanion", "vimtex" },
      per_filetype = { org = { "orgmode" } },
      providers = {
        vimtex = {
          name = "vimtex",
          module = "blink.compat.source",
        },
        orgmode = {
          name = "Orgmode",
          module = "orgmode.org.autocompletion.blink",
          fallbacks = { "buffer" },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
