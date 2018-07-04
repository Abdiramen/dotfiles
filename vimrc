" Use Vim defaults (instead of vi)
set nocompatible
set visualbell
" Enable auto indentation
" set cindent
" Tabs are four spaces wide
set shiftwidth=4
set tabstop=2
set expandtab

" Enable mouse support
if has("mouse")
  set mouse=a
endif


" Language defualts
autocmd Filetype cpp setlocal tabstop=2
autocmd Filetype make setlocal noexpandtab
autocmd Filetype go setlocal noexpandtab
autocmd Filetype javascript setlocal tabstop=2
autocmd Filetype latex setlocal tabstop=2
autocmd Filetype html setlocal tabstop=2


" Comfy mappings
"" I don't like pressing SHIFT ; every time
map ; :
noremap ;; ;
"" Copy to the + register
map <F2> :%y + <CR>
"" 80 column limit (wow old school)
set colorcolumn=80

" Visual ques
"" Spell is hard
set spell

"" Show tab, spaces, and newlines
set encoding=utf-8
set list      " Show tabs and newlines
set listchars=tab:▸\ ,eol:¬,trail:█,extends:>,precedes:< 

"" Under line
set cursorline " hard to see with AnonymousPro font at size 9


" A E S T H E T I C S

"" Fallback font
"set gfn=fontawesome
"" Hyrid line numbers
set number relativenumber

"" Syntax highlitighting
syntax on

call plug#begin('~/.vim/bundle/')
Plug 'ajmwagar/vim-deus'
Plug 'dracula/vim'
Plug 'posva/vim-vue'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'alvan/vim-closetag'
cal  plug#end()

filetype indent off

"" color-scheme and pretty colors
colorscheme deus
set background=dark
set t_Co=256
"colorscheme dracula

highlight Normal ctermbg=none

"For lightline.vim
set laststatus=2

" Disable GHC linter if in a Haskell Stack project
let g:ale_linters = {
\    'haskell': ['ghc'],
\}

let g:ale_haskell_ghc_options = '-fno-code -v0 -dynamic'
