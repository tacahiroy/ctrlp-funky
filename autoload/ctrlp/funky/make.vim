" Language: make
" Author: yalin.wang
" License: The MIT License

"support make file target parse
"support format:
"A:B  or  $(A):B
function! ctrlp#funky#make#filters()
  let filters = [
        \ { 'pattern': '\m^\(\w\+\|\$([^)]\+)\)\s*:[^\n]*\ze\n\t',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
