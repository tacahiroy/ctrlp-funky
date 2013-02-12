" File: autoload/ctrlp/funky/cpp.vim
" Description: adds Objective-C support to ctrlp's funky extension
" Author: tokorom
" License: the MIT License

function! ctrlp#funky#objc#filter(bufnr)
  let filter = [{ 'pattern': '\m\C^\(-\|+\)\s*(\S\+)\s*.*',
                \ 'filter': []}
  \ ]

  " Add the filter for cpp
  let cpp_filter = [{ 'pattern': '\m^\w.*\w(.*)',
                    \ 'filter': []}
  \ ]
  call extend(filter, cpp_filter)

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

