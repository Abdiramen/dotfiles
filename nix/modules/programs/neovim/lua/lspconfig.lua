local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre"
local async = event == "BufWritePost"

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
  vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.jump, { count = 1, float = true })
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.jump, { count = -1, float = true })
  vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>")
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
  vim.keymap.set("n", "<leader>df", function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references)

  ---- formatting
  --if client.supports_method("textDocument/formatting") then
  --  vim.keymap.set("n", "<Leader>f", function()
  --    vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --  end, { buffer = bufnr, desc = "[lsp] format" })

  --  vim.keymap.set("x", "<Leader>f", function()
  --    vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --  end, { buffer = bufnr, desc = "[lsp] format" })

  --  -- format on save
  --  vim.api.nvim_create_autocmd("BufWritePre", {
  --    buffer = bufnr,
  --    group = group,
  --    callback = function()
  --      vim.lsp.buf.format({ bufnr = bufnr, async = async })
  --    end
  --  })
  --end
end

require('lspconfig').gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig').rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig').solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig').ts_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}
require('lspconfig').buf_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require('lspconfig').csharp_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { string.format("%s/bin/csharp-ls", csharp_ls) },
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
    ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
  },
}

-- require('lspconfig').omnisharp.setup {
--   cmd = {
--     "OmniSharp",
--     "--languageserver",
--     "--hostPID",
--     tostring(vim.fn.getpid())
--   },
--   capabilities = capabilities,
--   on_attach = on_attach,
--   handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
--   RoslynExtensionsOptions = {
--     EnableAnalyzersSupport = true,
--     EnableImportCompletion = true,
--   },
-- }

require('lspconfig').yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml",
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
      },
    },
  },
}

require('lspconfig').gdscript.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require('lspconfig').nixd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    nixd = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}

require('lspconfig').lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', "capabilities", "csharp_ls", "authors" },
      },
    },
  },
}

require('lspconfig').texlab.setup {
  capabilities = capabilities,
  on_attach = on_attach,

}
