" File: autoload/ctrlp/funky/nerdtree.vim
" Description: adds NERDTree support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: the MIT License

let s:filter = [{ 'pattern': '\m\C^\s*[▸▾|~+].*\/$',
                \ 'filter': []}
\ ]

function! ctrlp#funky#nerdtree#filter(bufnr)
  let g:ctrlp_open_func['Funky'] = 'ctrlp#funky#goto_line'
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#nerdtree#get_filter()
  return s:filter
endfunction

