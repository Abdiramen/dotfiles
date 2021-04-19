" Use VIM idefaults (instead of VI)
set nocompatible
set visualbell
set nomodeline

" Tabs to spaces
set shiftwidth=2
set tabstop=2
set expandtab

set bs=2

" Enable mouse support
if has("mouse")
  set mouse=a
endif

" Show tab, space, and newlines
set encoding=utf-8
set list " Show tabs and newlines
set listchars=tab:▸\ ,eol:¬,trail:█,extends:>,precedes:<

" Under line
set cursorline
set number relativenumber

" search
set hlsearch

"" Windows splits
"set splitright

"" Tags
set tags=tags

call plug#begin('~/.vim/bundle/')
" navigation
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            "\ Plug 'ryanoasis/vim-devicons' " icons

Plug 'dense-analysis/ale' " Linting and so much more
Plug 'tpope/vim-fugitive' " git commands
Plug 'airblade/vim-gitgutter'

" Themes
Plug 'challenger-deep-theme/vim', {'as': 'challenger' } " under water color scheme
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'fenetikm/falcon'

" Status line
Plug 'itchyny/lightline.vim'

" Syntax
Plug 'cespare/vim-toml'
Plug 'lifepillar/pgsql.vim'
Plug 'LnL7/vim-nix'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

"colorscheme falcon
colorscheme challenger_deep
"hi Normal guibg=NONE ctermbg=NONE

let NERDTreeShowLineNumber=1
set laststatus=2

let g:ale_linters = {'c': ['clang'], 'c++': ['clang', 'g++']}
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
let g:ale_cpp_clang_options = '-Wall -O2 -std=c++17'
