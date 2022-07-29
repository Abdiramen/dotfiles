{pkgs, ... }:

let
  wiki_path = ~/vimwiki;
  # NOTE: make a package to share common paths or variables
  bin = ~/bin;
  challenger_deep = pkgs.vimUtils.buildVimPlugin {
    name = "challeger_deep";
    src = pkgs.fetchFromGitHub {
      owner = "challenger-deep-theme/";
      repo = "vim";
      rev = "b3109644b30f6a34279be7a7c9354360be207105";
      sha256 = "1q3zjp9p5irkwmnz2c3fk8xrpivkwv1kc3y5kzf1sxdrbicbqda8";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = ale;
        config = "
        let g:ale_linters = {'c': ['clang'], 'c++': ['clang', 'g++']}
        let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
        let g:ale_cpp_clang_options = '-Wall -O2 -std=c++17'
        ";
      }
      fugitive
      gitgutter
      {
        plugin = lightline-vim;
        config = "set laststatus=2";
      }
      {
        plugin = challenger_deep;
        config = "
          colorscheme challenger_deep
          set termguicolors
        ";
      }
      vim-toml
      vim-nix
      fzf-vim
      {
        plugin = vimwiki;
        config = ''
          let wiki_1 = {}
          let wiki_1.name = 'base'
          let wiki_1.path = '${toString wiki_path}'
          let wiki_1.auto_tags = 1

          let wiki_2 = {}
          let wiki_2.name = 'test'
          let wiki_2.path = '~/testwiki'
          let wiki_2.auto_tags = 1

          let g:vimwiki_list = [wiki_1, wiki_2]
          "let g:vimwiki_folding = 'syntax'
        '';
      }
      mattn-calendar-vim
      {
        plugin = nerdtree;
        config = "let NERDTreeShowLineNumber=1";
      }
      nerdtree-git-plugin
    ];

    extraConfig = ''
      set visualbell
      set cursorline
      set tabstop=2 shiftwidth=2 expandtab
      set number relativenumber
      set hlsearch
      set splitright
      let mapleader = " "
      filetype plugin on
      syntax on

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

      " vimwiki template
      au BufNewFile ${toString wiki_path}/diary/*.wiki :silent 0r !${toString bin}/nvim/generate-vimwiki-diary-template.py '%'
    '';
  };
}
