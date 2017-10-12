" {{{1 Global 

" Manatee's leader key is used to control navigation through UI windows.
let mapleader = "\<Space>"

" Unhighlight search.
noremap <silent> <A-n> :nohl<CR>

" {{{1 Insert mode 

" Quickly exit insert mode.
inoremap jk <Esc>

" Insert new line even when the popup menu is visible.
inoremap <expr> <CR> (pumvisible() ? "\<C-y>\<CR>" : "\<CR>")

" Expand snippet.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" {{{1 User interface
" Prevent tagbar from overriding space leader.
let g:tagbar_map_showproto = ""

function! ManateeWinNERDTree(open)
    if a:open == 1
        NERDTreeFocus
    else
        NERDTreeClose
    endif
endfunction

function! ManateeWinTagbar(open)
    if a:open == 1
        TagbarOpen j
    else
        TagbarClose
    endif
endfunction

nnoremap <silent> <Leader>n :call ManateeWinNERDTree(1)<CR>
nnoremap <silent> <Leader>N :call ManateeWinNERDTree(0)<CR>

augroup manatee#win#nerd_tree
    autocmd!
    autocmd FileType nerdtree noremap <buffer> <Leader>n <C-w>p
    autocmd FileType tagbar noremap <buffer> <Leader>n <C-w>p:call ManateeWinNERDTree(1)<CR>
augroup END

nnoremap <silent> <Leader>t :TagbarOpen j<CR>
nnoremap <silent> <Leader>T :TagbarClose<CR>

augroup manatee_win_tagbar
    autocmd!
    autocmd FileType nerdtree noremap <buffer> <Leader>t <C-w>p:call ManateeWinTagbar(1)<CR>
    autocmd FileType tagbar noremap <buffer> <Leader>t <C-w>p
augroup END

" {{{1 System
nnoremap <silent> <Leader>p :PlugUpdate<CR>

augroup manatee#win#plug
    autocmd!
    autocmd FileType vim-plug noremap <buffer> <Leader>P <C-w>q
augroup END

" {{{1 Closing

" vim: fdm=marker :
