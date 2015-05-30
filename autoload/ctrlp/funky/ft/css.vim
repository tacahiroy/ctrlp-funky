" Language: CSS
" Author: Takahiro Yoshihara <tacahiroy@gmail.com>
" License: The MIT License

function! ctrlp#funky#ft#css#filters()
  let filters = [
        \ { 'pattern': '\v^[\t ]*[#\.]',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
