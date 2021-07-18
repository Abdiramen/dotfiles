{pkgs, ... }:

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
        plugin = vim-plug;
        config = "
          call plug#begin('~/.vim/bundle/')
            Plug 'challenger-deep-theme/vim', {'as': 'challenger' }
          call plug#end()
          colorscheme challenger_deep
        ";
      }
      vim-toml
      vim-nix
      fzf-vim
      vimwiki
      {
        plugin = nerdtree;
        config = "let NERDTreeShowLineNumber=1";
      }
      nerdtree-git-plugin
    ];

    extraConfig = ''
      set visualbell
      set cursorline
      set number relativenumber
      set hlsearch
    '';
  };
}
