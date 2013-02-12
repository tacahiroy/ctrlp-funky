" File: autoload/ctrlp/funky/markdown.vim
" Description: adds markdown support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^#\{1,3}[\t ]\+\S\+',
                \ 'filter': [] },
              \ { 'pattern': '\m\C^[-=]\{3,}$',
              \   'filter': [],
              \   'offset': -1 }
\ ]

function! ctrlp#funky#markdown#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#markdown#get_filter()
  return s:filter
endfunction

