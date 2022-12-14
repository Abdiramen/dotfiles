{pkgs, ... }:

let
  wiki_0_path = ~/vimwiki;
  wiki_1_path = ~/git/interviews;
  wiki_path_html = ~/vimwiki_html;
  # NOTE: make a package to share common paths or variables
  bin = ~/bin;
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # to find plugins run:
    # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
    plugins = with pkgs.vimPlugins;[
      fugitive
      gitgutter
      vim-toml
      vim-nix
      nerdtree-git-plugin
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
      {
        plugin = gruvbox-nvim;
        type = "lua";
        config = ''
          vim.o.background = "dark"
          require("gruvbox").setup({
            undercurl = true,
            underline = true,
            bold = true,
            italic = true,
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
          })
          -- vim.cmd([[colorscheme gruvbox]])
        '';
      }
      {
        plugin = tokyonight-nvim;
      }
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
      }
      {
        # Diagnostics, code actions, and more using neovim directly
        plugin = null-ls-nvim;
      }
      {
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
          require('lspconfig').gopls.setup{
            capabilities = capabilities,
            on_attach = function()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
            vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
            vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
            vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
            end,
          }
          require('lspconfig').rust_analyzer.setup{
            capabilities = capabilities,
            on_attach = function()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
            vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
            vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
            vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
            end,
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
      luasnip
      cmp_luasnip
    ];
    extraPackages = with pkgs; [
      # language servers
      ## Go
      gopls
      ## Rust
      rust-analyzer
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
  };
}
