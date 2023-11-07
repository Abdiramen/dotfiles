{pkgs, ... }:

let
  wiki_0_path = ~/vimwiki;
  wiki_1_path = ~/git/interviews;
  wiki_path_html = ~/vimwiki_html;
  # NOTE: make a package to share common paths or variables
  bin = ~/bin;
  nvim_prettier = pkgs.vimUtils.buildVimPlugin {
    name = "nvim_prettier";
    src = pkgs.fetchFromGitHub {
      owner = "MunifTanjim";
      repo = "prettier.nvim";
      rev = "d98e732cb73690b07c00c839c924be1d1d9ac5c2";
      sha256 = "4xq+caprcQQotvBXnWWSsMwVB2hc5uyjrhT1dPBffXI=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # to find plugins run:
    # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
    plugins = with pkgs.vimPlugins;[
      fugitive
      gitgutter
      vim-toml
      vim-nix
      # wiki, note taking productivity tools
      {
        # Personl wiki for vim
        plugin = vimwiki;
        config = ''
          let wiki_0 = {}
          let wiki_0.name = 'base'
          let wiki_0.path = '${toString wiki_0_path}'
          let wiki_0.path_html = '${toString wiki_path_html}'
          let wiki_0.auto_tags = 1

          let wiki_1 = {}
          let wiki_1.name = 'interviews'
          let wiki_1.path = '${toString wiki_1_path}'
          let wiki_1.path_html = '${toString wiki_path_html}'
          let wiki_1.auto_tags = 1

          let g:vimwiki_list = [wiki_0, wiki_1]
          "let g:vimwiki_folding = 'syntax'

          " Vimwiki
          function! VimwikiLinkHandler(link)
            " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
            "   1) [[vfile:~/Code/PythonProject/abc123.py]]
            "   2) [[vfile:./|Wiki Home]]
            let link = a:link
            if link =~# '^vfile:'
              let link = link[1:]
            else
              return 0
            endif
            let link_infos = vimwiki#base#resolve_link(link)
            if link_infos.filename == '''
              echomsg 'Vimwiki Error: Unable to resolve link!'
              return 0
            else
              exe 'tabnew ' . fnameescape(link_infos.filename)
              return 1
            endif
          endfunction

          "" vimwiki diary template
          au BufNewFile ${toString wiki_0_path}/diary/*.wiki :silent 0r !${toString bin}/nvim/generate-vimwiki-diary-template.py ${toString wiki_0_path}
        '';
      }
      mattn-calendar-vim

      # neovim lua plugins
      ## Neovim file browser
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          require("neo-tree").setup{}
          -- make sure to escape \
          vim.keymap.set('n', '\\', '<cmd>Neotree toggle current reveal_force_cwd<CR>', { desc = "Toggle neotree reveal. Replaces current window like netrw"})
          vim.keymap.set('n', '|', '<cmd>Neotree reveal<CR>', { desc = "Reveals neotree in the left hand drawer."})
          -- kinda cool, but kind of a headache since it changes the cwd
          -- vim.keymap.set('n', '<leader>gd', '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<CR>', { desc = "Opens directory of file under curse in floating pane"})
          vim.keymap.set('n', '<leader>b', '<cmd>Neotree toggle show buffers right<CR>', {})
          vim.keymap.set('n', '<leader>s', '<cmd>Neotree float git_status<CR>', {})
          '';
      }
      {
        plugin = plenary-nvim;
        type = "lua";
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
      }
      {
        plugin = nui-nvim;
        type = "lua";
      }
      ## Colorscheme
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          vim.cmd.colorscheme "catppuccin"
          '';
      }
      #{
      #  plugin = gruvbox-nvim;
      #  type = "lua";
      #  config = ''
      #    vim.o.background = "dark"
      #    require("gruvbox").setup({
      #      undercurl = true,
      #      underline = true,
      #      bold = true,
      #      italic = true,
      #      strikethrough = true,
      #      invert_selection = false,
      #      invert_signs = false,
      #      invert_tabline = false,
      #      invert_intend_guides = false,
      #      inverse = true, -- invert background for search, diffs, statuslines and errors
      #      contrast = "", -- can be "hard", "soft" or empty string
      #      palette_overrides = {},
      #      overrides = {},
      #      dim_inactive = false,
      #      transparent_mode = false,
      #    })
      #    -- vim.cmd([[colorscheme gruvbox]])
      #  '';
      #}
      #{
      #  plugin = tokyonight-nvim;
      #}
      ## Statusline
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup{
            -- options = {
            --   theme = 'tokyonight'
            -- }
          }
        '';
      }
      {
        # Extendable fuzzy finder over lists aka vim-fzf replacement
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
          vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
          '';
      }
      {
        # Diagnostics
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          require('trouble').setup{}
          '';
      }
      {
        # Config for Nvim LSP client (`:help lsp`)
        # see also `:help lsp-config`
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
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
            vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>")
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

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

          require('lspconfig').gopls.setup{
            capabilities = capabilities,
            on_attach = on_attach,
          }
          require('lspconfig').rust_analyzer.setup{
            capabilities = capabilities,
            on_attach = on_attach,
          }
          require('lspconfig').solargraph.setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }

          require('lspconfig').tsserver.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
            cmd = { "typescript-language-server", "--stdio" }
          }

          require('lspconfig').bufls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }

          require('lspconfig').yamlls.setup{
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
          '';
      }
      ## nvim cmp and additions
      {
        # Completion Engine for nvim written in lua with full LSP support
        # (LSP autocomplete)
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          -- Set up lspconfig.
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          vim.opt.completeopt={"menu", "menuone", "noselect"}
          -- Set up nvim-cmp.
          local cmp = require'cmp'
      
          cmp.setup({
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
            window = {
              -- completion = cmp.config.window.bordered(),
              -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
            }, {
              { name = 'buffer' },
            })
          })
      
          -- Set configuration for specific filetype.
          cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
              { name = 'buffer' },
            })
          })      
          '';
      }
      {
        plugin = cmp-buffer;
        type = "lua";
      }
      {
        plugin = cmp-path;
        type = "lua";
      }
      {
        plugin = cmp-nvim-lsp;
        type = "lua";
      }
      {
        # Diagnostics, code actions, and more using neovim directly
        plugin = null-ls-nvim;
        type = "lua";
        config = ''
          -- local null_ls = require("null-ls")

          -- null_ls.setup({
          --   on_attach = on_attach,
          --   sources = {
          --     null_ls.builtins.formatting.prettier,
          --   },
          -- })
        '';
      }
      {
        plugin = nvim_prettier;
        type = "lua";
        config = ''
          local prettier = require("prettier")

          prettier.setup({
            bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
            filetypes = {
              "css",
              "graphql",
              "html",
              "javascript",
              "javascriptreact",
              "json",
              "less",
              "markdown",
              "scss",
              "typescript",
              "typescriptreact",
              "yaml",
            },
            cli_options = {
              arrow_parens = "always",
              -- plugins: [require("prettier-plugin-tailwindcss")],
              semi = true,
              single_quote = false,
              tab_width = 2,
              trailingComma = "es5",
              use_tabs = true,
            },
            ["null-ls"] = {
              condition = function()
                return prettier.config_exists({
                  -- if `false`, skips checking `package.json` for `"prettier"` key
                  check_package_json = true,
                })
              end,
              runtime_condition = function(params)
                -- return false to skip running prettier
                return true
              end,
              timeout = 5000,
            }
          })
          '';
      }
      luasnip
      cmp_luasnip
    ];
    extraPackages = with pkgs; [
      # language servers
      ## Go
      gopls
      ### protobuf (buf)
      buf-language-server
      ## Rust
      rust-analyzer
      ## ruby
      solargraph
      ## typescript
      nodePackages_latest.typescript-language-server
      #nodePackages_latest.prettier # needed for correct prettier formatting
      #yaml
      yaml-language-server
    ];

    extraConfig = ''
      " Settings
      set visualbell
      set cursorline
      set tabstop=2 shiftwidth=2 expandtab
      set number relativenumber
      set hlsearch
      set splitright
      let mapleader = " "
      filetype plugin on
      syntax on      
    '';

    extraLuaConfig = ''
      vim.opt.clipboard = 'unnamedplus'
      '';
  };

}
