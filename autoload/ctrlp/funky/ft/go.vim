" Language: Go
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#ft#go#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*func[\t ]\+',
        \   'formatter': [] },
  \ ]
  return filters
endfunction
