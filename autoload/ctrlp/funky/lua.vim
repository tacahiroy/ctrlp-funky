" Language: Lua
" Author: hlissner
" License: The MIT License

function! ctrlp#funky#lua#filters()
  let filters = [
        \ { 'pattern': '\v\s*function\s+\w.+\s*\(',
        \   'formatter': ['\m\C^[\t ]*', '', ''] },
        \ { 'pattern': '\v\s*\w.+\s*\=\s*function\s*\(',
        \   'formatter': ['\v\C^[\t ]*', '', 'g'] }
  \ ]
  return filters
endfunction
