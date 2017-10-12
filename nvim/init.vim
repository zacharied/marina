" {{{1 Opening
" Reload configuration when saved.
augroup manatee#reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC,$DOTS/nvim/manatee/* nested source $MYVIMRC
augroup END

" Load each config section.
let g:manatee_vim#directory = expand('$DOTS') . '/nvim/manatee'
function! SourceManatee(file)
    exe 'source ' . g:manatee_vim#directory . '/' . a:file 
endfunction 

call SourceManatee('plugins.vim')
call SourceManatee('keybinds.vim')
call SourceManatee('text.vim')
call SourceManatee('command.vim')
call SourceManatee('interface.vim')

" {{{1 Closing

" vim: fdm=marker :
