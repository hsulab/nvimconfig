return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/Documents/orgfiles/**/*",
      org_default_notes_file = "~/Documents/orgfiles/refile.org",
      org_tags_column = 120,
      org_capture_templates = {
        f = {
          description = "Fixme",
          template = "* TODO %t %? %x",
          target = "~/Documents/orgfiles/fixme.org",
        },
        r = {
          description = "Research",
          template = "* TODO %t %? %x",
          target = "~/Documents/orgfiles/research.org",
        },
      },
    })

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}
