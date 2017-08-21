" Language: Groovy
" Author: Tacahiroy <tacahiroy@gmail.com>
" License: The MIT License

function! ctrlp#funky#ft#groovy#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*def[\t ]\+\w\+([^)]*)[\t ]*\n*{',
        \   'formatter': ['^[\t ]*', '', ''] }
  \ ]
  return filters
endfunction
