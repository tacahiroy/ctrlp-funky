" File: autoload/ctrlp/funky/sh.vim
" Description: adds sh support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^[\t ]*\(function[\t ]\+\)\?[_a-zA-Z][_a-zA-Z0-9]\+[\t ]*([\t ]*)[\t ]*\n*{',
                \ 'filter': []}
\]

function! ctrlp#funky#sh#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#sh#get_filter()
  return s:filter
endfunction

