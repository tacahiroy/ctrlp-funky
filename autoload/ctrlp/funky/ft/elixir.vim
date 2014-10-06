" Language: elixir
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#ft#elixir#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*def[\t ]\+\S\+.*do[\t ]*$',
        \   'formatter': []}
  \ ]
  return filters
endfunction
