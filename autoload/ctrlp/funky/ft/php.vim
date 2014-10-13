" Language: PHP (php)
" Author: robmiller
" License: The MIT License

function! ctrlp#funky#ft#php#filters()
  let filters = [
        \ { 'pattern': '\v^\s*\w*(\s*\w*)\s*function\s+[&]*\w+\s*\(',
        \   'formatter': ['\m\C^[\t ]*', '', ''] }
  \ ]

  if get(g:, 'ctrlp_funky_php_requires', 0)
    call extend(filters, [
          \ { 'pattern': '\m\C\<require\(_once\)\?\([\t ]\+[''"]\|[\t ]*(\)',
          \   'formatter': [] }]
    \ )
  endif

  if get(g:, 'ctrlp_funky_php_includes', 0)
    call extend(filters, [
          \ { 'pattern': '\m\C\<include\(_once\)\?\([\t ]\+[''"]\|[\t ]*(\)',
          \   'formatter': [] }]
    \ )
  endif

  return filters
endfunction
