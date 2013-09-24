" Language: YAML
" Author: dusans
" License: The MIT License

function! ctrlp#funky#yaml#filters()
  let filters = [
        \ { 'pattern': '\v\C^\s*.*:',
        \   'formatter': ['\v\C^\s*', '', ''] }
  \ ]
  return filters
endfunction
