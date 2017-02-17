" Use Vim defaults (instead of vi)
set nocompatible

" Enable auto indentation
"set cindent

" Tabs are four spaces wide
set tabstop=4

" Shows 
set list      " Show tabs and newlines
set listchars=tab:▸\ ,eol:¬,trail:█,extends:>,precedes:< 

" Convert tabs to spaces
set expandtab

" Enable mouse support
if has("mouse")
  set mouse=a
endif

" Set a colorscheme. See http://code.google.com/p/vimcolorschemetest/ 
"colorscheme slate

" Use colorscheme colors that look better on a dark terminal
set background=dark
