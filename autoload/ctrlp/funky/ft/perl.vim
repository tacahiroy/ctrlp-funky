" Language: Perl
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#ft#perl#filters()
  let filters = [
        \ { 'pattern': '\m\C\<sub\>[\t ]*',
        \   'formatter': [] }
  \ ]

  return filters
endfunction
