require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
      },
    },
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
        index = "index.norg",
      },
    },
    ["core.integrations.treesitter"] = {
      config = {
        install_parsers = "false",
      },
    },
    ["core.journal"] = {
      config = {
        journal_folder = "journal_test",
        strategy       = "flat",
        template_name  = "journal_template.norg",
        use_template   = "true",
      },
    },
    ["core.esupports.metagen"] = {
      config = {
        author = authors,
      },
    },
    -- ["core.tangle"] = {},
  }
})
