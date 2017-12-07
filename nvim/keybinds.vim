" {{{1 Global

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

" Prevent tagbar from overriding spacebar bindings.
let g:tagbar_map_showproto = ""

function! VimrcWinNERDTree(open)
    if a:open == 1
        NERDTreeFocus
    else
        NERDTreeClose
    endif
endfunction

function! VimrcWinTagbar(open)
    if a:open == 1
        TagbarOpen j
    else
        TagbarClose
    endif
endfunction

nnoremap <silent> <Leader>n :call VimrcWinNERDTree(1)<CR>
nnoremap <silent> <Leader>N :call VimrcWinNERDTree(0)<CR>

augroup vimrc_win_nerd_tree
    autocmd!
    autocmd FileType nerdtree noremap <buffer> <Leader>n <C-w>p
    autocmd FileType tagbar noremap <buffer> <Leader>n <C-w>p:call VimrcWinNERDTree(1)<CR>
augroup END

nnoremap <silent> <Leader>t :TagbarOpen j<CR>
nnoremap <silent> <Leader>T :TagbarClose<CR>

augroup vimrc_win_tagbar
    autocmd!
    autocmd FileType nerdtree noremap <buffer> <Leader>t <C-w>p:call VimrcWinTagbar(1)<CR>
    autocmd FileType tagbar noremap <buffer> <Leader>t <C-w>p
augroup END

" {{{1 System

nnoremap <silent> <Leader>p :PlugUpdate<CR>

augroup vimrc_win_plug
    autocmd!
    autocmd FileType vim-plug noremap <buffer> <Leader>P <C-w>q
augroup END

" {{{1 Buffers

" Basic buffer navigation.
nnoremap <silent> <A-j> :bprev<CR>
nnoremap <silent> <A-k> :bnext<CR>
nnoremap <silent> <A-S-j> :bfirst<CR>
nnoremap <silent> <A-S-k> :blast<CR>
nnoremap <silent> <A-q> :bdelete<CR>

" Buffer list.
nnoremap <silent> <leader>b :buffers<CR> 



" {{{1 Closing

" vim: fdm=marker :
