{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types mkOption;
in
{
  options = {
    neovim.enable = lib.mkEnableOption "enables neovim configs";
    neorg.config = mkOption {
      type = types.str;
      default = (builtins.readFile ./lua/neorg.lua);
    };
    neorg.authors = mkOption {
      type = types.str;
      default = "Abdirahman A. Osman";
    };
  };
  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      # to find plugins run:
      # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
      plugins = [
        pkgs.vimPlugins.fugitive
        pkgs.vimPlugins.gitgutter
        pkgs.vimPlugins.vim-toml
        pkgs.vimPlugins.vim-nix
        pkgs.vimPlugins.mattn-calendar-vim
        pkgs.vimPlugins.plenary-nvim
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.nui-nvim
        # neovim lua plugins
        ## Neovim file browser
        {
          plugin = pkgs.vimPlugins.neo-tree-nvim;
          type = "lua";
          config = (builtins.readFile ./lua/neo_tree_nvim.lua);
        }
        ## Colorscheme
        {
          plugin = pkgs.vimPlugins.catppuccin-nvim;
          type = "lua";
          config = ''
            vim.cmd.colorscheme "catppuccin"
          '';
        }
        ## Statusline
        {
          plugin = pkgs.vimPlugins.lualine-nvim;
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
          plugin = pkgs.vimPlugins.telescope-nvim;
          type = "lua";
          config = (builtins.readFile ./lua/telescope.lua);
        }
        {
          # Diagnostics
          plugin = pkgs.vimPlugins.trouble-nvim;
          type = "lua";
          config = ''
            require('trouble').setup{}
          '';
        }
        {
          plugin = pkgs.vimPlugins.csharpls-extended-lsp-nvim;
          type = "lua";
          config = ''
            require('csharpls_extended')
          '';
        }
        {
          # Config for Nvim LSP client (`:help lsp`)
          # see also `:help lsp-config`
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          type = "lua";
          config = (builtins.readFile ./lua/lspconfig.lua);
        }
        ## nvim cmp and additions
        {
          # Completion Engine for nvim written in lua with full LSP support
          # (LSP autocomplete)
          plugin = pkgs.vimPlugins.nvim-cmp;
          type = "lua";
          config = (builtins.readFile ./lua/nvim_cmp.lua);
        }
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.cmp-path
        pkgs.vimPlugins.cmp-nvim-lsp
        {
          # Diagnostics, code actions, and more using neovim directly
          plugin = pkgs.vimPlugins.null-ls-nvim;
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
        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.cmp_luasnip
        pkgs.vimPlugins.nvim-nio
        {
          plugin = (
            pkgs.vimPlugins.nvim-treesitter.withPlugins (
              _:
              pkgs.vimPlugins.nvim-treesitter.allGrammars ++ [ (pkgs.tree-sitter-grammars.tree-sitter-norg-meta) ]
            )
          );
          type = "lua";
          config = ''
            require("nvim-treesitter.configs").setup {
              highlight = {
                enable = true,
              }
            }
          '';
        }
        {
          plugin = pkgs.vimPlugins.neorg;
          type = "lua";
          config = config.neorg.config;
        }
        pkgs.vimPlugins.nvim-treesitter-parsers.gdshader
      ];
      extraPackages = with pkgs; [
        # language servers
        ## Go
        gopls
        ### protobuf (buf)
        buf
        ## Rust
        rust-analyzer
        ## ruby
        solargraph
        ## typescript
        nodePackages_latest.typescript-language-server
        #nodePackages_latest.prettier # needed for correct prettier formatting
        #yaml
        yaml-language-server
        yarn

        # csharp, this is going to be a wild ride
        csharp-ls
        omnisharp-roslyn
        dotnetCorePackages.sdk_8_0_3xx

        # nix lsp
        nixd
        nixfmt-rfc-style

        # lua lsp
        lua-language-server

        # LaTeX lsp
        texlab
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

      extraLuaPackages = luaPkgs: [
        luaPkgs.pathlib-nvim
        luaPkgs.lua-utils-nvim
      ];
      extraLuaConfig = ''
        vim.opt.clipboard = 'unnamedplus'
        vim.wo.wrap = false
        local csharp_ls = "${pkgs.csharp-ls}"
        local authors = "${config.neorg.authors}"
      '';
    };
  };
}
