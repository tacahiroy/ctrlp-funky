" File: autoload/ctrlp/funky/php.vim
" Description: adds PHP support to ctrlp's funky extension
" Author: robmiller
" License: The MIT License

let s:filter = [{ 'pattern': '\v\s*function\s+\w.+\s*\(',
                \ 'filter': ['\m\C^[\t ]*', '', '']}
                \ ]

if get(g:, 'ctrlp_funky_php_requires', 0)
  call extend(s:filter, [{ 'pattern': '\m\C\<require\(_once\)\?\([\t ]\+[''"]\|[\t ]*(\)',
                         \ 'filter': []}])
endif

if get(g:, 'ctrlp_funky_php_includes', 0)
  call extend(s:filter, [{ 'pattern': '\m\C\<include\(_once\)\?\([\t ]\+[''"]\|[\t ]*(\)',
                         \ 'filter': []}])
endif

function! ctrlp#funky#php#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#php#get_filter()
  return s:filter
endfunction

