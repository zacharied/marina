" {{{1 Opening

" Reload configuration when saved.
augroup vimrc_autoreload
    autocmd!
    autocmd BufWritePost $MYVIMRC,$DOTS/nvim/*.vim nested source $MYVIMRC
augroup END

function! VimrcSource(f)
    exe 'source ' . '$DOTS/nvim/' . a:f
endfunction

call VimrcSource('plugins.vim')
call VimrcSource('keybinds.vim')
call VimrcSource('text.vim')
call VimrcSource('command.vim')
call VimrcSource('interface.vim')
call VimrcSource('language.vim')

" {{{1 Closing

" vim: fdm=marker :
