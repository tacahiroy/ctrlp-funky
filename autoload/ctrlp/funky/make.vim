" Language: make
" Author: yalin.wang
" License: The MIT License

"support make file target parse
"support format:
"A:B  or  $(A):B or A $(B) : B
function! ctrlp#funky#make#filters()
  let filters = [
        \ { 'pattern': '\m^[^:\t#''"]\+:=\@![^:\t]*\ze\n\|^\s*define\s\+',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
