" File: autoload/ctrlp/funky/php.vim
" Description: adds PHP support to ctrlp's funky extension
" Author: robmiller
" License: The MIT License

let s:filter = [{ 'pattern': '\v\s*function\s+\w.+\s*\(',
                \ 'filter': []}
                \ ]

function! ctrlp#funky#php#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#php#get_filter()
  return s:filter
endfunction

