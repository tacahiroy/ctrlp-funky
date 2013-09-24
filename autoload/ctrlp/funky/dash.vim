" Language: Debian Almquist shell (dash)
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#dash#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*\([\t ]\+\)*[_a-zA-Z][_a-zA-Z0-9]\+[\t ]*\(([\t ]*)\)\?[\t ]*\n*{',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
