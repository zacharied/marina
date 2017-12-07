" {{{1 Buffers

set hidden

" {{{1 Editor

set scrolloff=3

" {{{1 Cursor

" Highlighting matched parentheses is kind of annoying.
let loaded_matchparen = 1

" {{{1 Gutter

set number
set relativenumber

" {{{1 Colorscheme

set termguicolors

let ayucolor = "mirage"
colorscheme ayu

" {{{1 Command line

" Hide completion messages.
set shortmess+=c

" {{{1 Closing

" Load statusline configuration.
exe 'source ' . expand('$DOTS/nvim/statusline.vim')

function! VimrcTagbarLightline(current, sort, fname, flags)
    return lightline#statusline(a:current == 1 ? 0 : 1)
endfunction
let g:tagbar_status_func = 'VimrcTagbarLightline'

" vim: fdm=marker :
