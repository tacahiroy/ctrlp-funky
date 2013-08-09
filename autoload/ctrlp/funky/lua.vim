" Language: Lua
" Author: hlissner
" License: The MIT License

let s:filter = [{ 'pattern': '\v\s*function\s+\w.+\s*\(',
                \ 'filter': ['\m\C^[\t ]*', '', '']},
              \ { 'pattern': '\v\s*\w.+\s*\=\s*function\s*\(',
                \ 'filter': ['\v\C^[\t ]*', '', 'g']}
                \ ]

function! ctrlp#funky#lua#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#lua#get_filter()
  return s:filter
endfunction
