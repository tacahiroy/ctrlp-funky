" Language: Apache Groovy
" Author: Takahiro YOSHIHARA <tacahiroy@gmail.com>
" License: The MIT License

function! ctrlp#funky#ft#groovy#filters()
  let p = '\m\C^[\t ]*'
  let p .= '\(def\|task\)[\t ]\+\w\+([^)]*)[\t ]*\n*{'

  let filters = [
        \ { 'pattern': p,
        \   'formatter': ['^[\t ]*', '', ''] }
  \ ]
  return filters
endfunction
