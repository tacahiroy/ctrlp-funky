" Language: Proto
" Author: timfeirg
" License: The MIT License

function! ctrlp#funky#ft#proto#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*message[\t ]\+',
        \   'formatter': [] },
        \ { 'pattern': '\m\C^[\t ]*service[\t ]\+',
        \   'formatter': [] },
  \ ]
  return filters
endfunction
