set nu
syntax on
colorscheme murphy
set hls
set incsearch

let mapleader=','
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w <Esc>:w<cr>
inoremap <leader>q <Esc>:wq<cr>
noremap <leader>q <Esc>:wq<cr>
inoremap jj <Esc>`^
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

com! FormatJson %!python3 -m json.tool

call plug#begin('~/.vim/plugged')

call plug#end()
