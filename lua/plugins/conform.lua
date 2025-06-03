return {
  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, go = true, python = true, rust = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          lsp_format_opt = "fallback"
          return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        json = { "prettier" },
        sh = { "shfmt" },
        go = { "gofmt", "goimports" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        stylua = {
          args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--stdin-filepath",
            "$FILENAME",
            "-",
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
