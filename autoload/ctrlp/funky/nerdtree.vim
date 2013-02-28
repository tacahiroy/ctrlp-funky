" File: autoload/ctrlp/funky/nerdtree.vim
" Description: adds NERDTree support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^\s*[▸▾|~+].*\/$',
                \ 'filter': []}
\ ]

" useful?
if get(g:, 'ctrlp_funky_nerdtree_include_files', 0)
  call add(s:filter, { 'pattern': '\m\C^\s\+.\+$',
                     \ 'filter': []})
endif

function! ctrlp#funky#nerdtree#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#nerdtree#get_filter()
  return s:filter
endfunction

" prevent splitting NERDTree window
function! ctrlp#funky#nerdtree#line_mode()
  return 1
endfunction

