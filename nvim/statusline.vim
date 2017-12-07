set noshowmode

" {{{1 Initialization

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \
    \ 'tabline': {
    \ 'left': [ [ 'bufferinfo' ],
    \           [ 'separator' ],
    \           [ 'bufferbefore', 'buffercurrent', 'bufferafter' ]
    \         ]
    \ }
\ }

let g:lightline.component_expand = {
    \ 'buffercurrent': 'lightline#buffer#buffercurrent',
    \ 'bufferbefore': 'lightline#buffer#bufferbefore',
    \ 'bufferafter': 'lightline#buffer#bufferafter'
\ }

let g:lightline.component_type = {
    \ 'buffercurrent': 'tabsel',
    \ 'bufferbefore': 'raw',
    \ 'bufferafter': 'raw',
\ }

" {{{1 Bufferline
set showtabline=2
let g:lightline_buffer_show_bufnr = 1
" {{{1 Mode map

" Configure icons to be shown per mode.
let g:lightline.mode_map = {
    \ 'n'     : '',
    \ 'i'     : '',
    \ 'R'     : '',
    \ 'v'     : '',
    \ 'V'     : '',
    \ "\<C-v>": '',
    \ 'c'     : '',
    \ 's'     : 's',
    \ 'S'     : 'S',
    \ "\<C-s>": 'S-BLOCK',
    \ 't'     : '',
\ }

" {{{1 Functions

let g:lightline.component_function = {
    \ 'bufferinfo': 'lightline#buffer#bufferinfo',
    \ 'mode': 'VimrcLightlineMode',
    \ 'filename_active': 'VimrcLightlineFilenameActive',
    \ 'filename_inactive': 'VimrcLightlineFilenameInactive'
\ }

let g:vimrc_lightline_icons = {
    \ 'tagbar': '',
    \ 'nerdtree': '',
    \ 'man': '',
    \ 'help': '' 
\ }

function! VimrcLightlineGetFileIcon()
    return &filetype == 'tagbar'   ? g:vimrc_lightline_icons.tagbar   :
         \ &filetype == 'nerdtree' ? g:vimrc_lightline_icons.nerdtree :
         \ &filetype == 'man'      ? g:vimrc_lightline_icons.man      :
         \ &filetype == 'help'     ? g:vimrc_lightline_icons.help     :
         \ 0
endfunction

function! VimrcLightlineMode()
    let icon = VimrcLightlineGetFileIcon()
    if icon == '0'
        return lightline#mode()
    else
        return icon
    endif
endfunction

function! VimrcLightlineFilenameActive()
    let icon = VimrcLightlineGetFileIcon()
    if icon == '0'
         return VimrcLightlineFilename()
    else
        return ''
    endif
endfunction

function! VimrcLightlineFilenameInactive()
    let icon = VimrcLightlineGetFileIcon()
    if icon == '0'
        return VimrcLightlineFilename()
    else
        return icon
    endif
endfunction

" Should only be called by VimrcLightlineFilenameInactive and VimrcLightlineFilenameActive.
function! VimrcLightlineFilename()
     let filename = expand('%:t')
     return filename == '' ? '∅' :
          \ filename
endfunction

" {{{1 Components

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'filename_active' ] ],
    \ 'right': [ [ ] ]
\ }

let g:lightline.inactive = {
    \ 'left': [ [ 'filename_inactive' ] ],
    \ 'right': [ [ ] ]
\ }

" {{{1 Closing

" vim: fdm=marker :
