" Language: Python (python)
" Author: pydave
" License: The MIT License

let s:filter = [{ 'pattern': '\v\C^\s*class\s+\w+\s*(\([^\)]+\))?:',
                \ 'filter': ['\v\C^\s*', '', '']},
              \ { 'pattern': '\v\C^\s*def\s+\w+\s*(\_.*):',
                \ 'filter': ['\v\C^\s*', '', '']}
\ ]

function! ctrlp#funky#python#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#python#get_filter()
  return s:filter
endfunction

