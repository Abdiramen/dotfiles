{pkgs, ... }:

let
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
