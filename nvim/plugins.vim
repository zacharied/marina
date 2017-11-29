call plug#begin('~/.local/share/vim-plug')

" {{{1 User interface

" Colorschemes.
Plug 'nightsense/seabird'
Plug 'nightsense/seagrey'
Plug 'ayu-theme/ayu-vim'

" {{{1 Language
Plug 'rust-lang/rust.vim'

Plug 'lervag/vimtex'

Plug 'zacharied/lc3.vim'

Plug 'Shougo/vinarise.vim'

" {{{1 Completion
" Core completion engine.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Snippets.
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#snippets_directory='$DOTS/nvim/snippets'

" Clang.
Plug 'zchee/deoplete-clang'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

" Vimscript.
Plug 'Shougo/neco-vim'

" Zsh.
Plug 'zchee/deoplete-zsh'

" Python.
Plug 'zchee/deoplete-jedi'

" Rust.
Plug 'racer-rust/vim-racer'

" {{{1 Navigation
" File explorer.
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTree', 'NERDTreeFocus'] } 

" Source code explorer.
Plug 'majutsushi/tagbar', { 'on': [ 'TagbarOpen' ] }

" {{{1 Source control
" Show git hunks changes in gutter.
Plug 'airblade/vim-gitgutter'

" Git wrapper.
Plug 'tpope/vim-fugitive'

" {{{1 Text manipulation
" Alignment motions.
Plug 'tommcdo/vim-lion'

" Surround motions.
Plug 'tpope/vim-surround'

" Comment motions.
Plug 'scrooloose/nerdcommenter'

" Create tables.
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }
let g:table_mode_map_prefix = '<A-t>'

" {{{1 Navigation
" Quick navigation to targets.
Plug 'easymotion/vim-easymotion'

" {{{1 Miscellaneous
" Allow the repeat command to do more.
Plug 'tpope/vim-repeat'

" Folder-local vim configuration.
Plug 'zacharied/vim-localvimrc'
let g:localvimrc_ask = 0
let g:localvimrc_notify_loaded = 1

" {{{1 Closing

call plug#end()

" vim: fdm=marker :
