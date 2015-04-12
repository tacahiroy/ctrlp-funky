" Language: LaTeX (tex)
" Author: Julian Wulfheide
" License: The MIT License

function! ctrlp#funky#ft#tex#filters()
  let filters = [
        \ { 'pattern': '\\\(sub\)\{0,2}section{',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
