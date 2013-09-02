" Language: YAML
" Author: dusans
" License: The MIT License

let s:filter = [{ 'pattern': '\v\C^\s*.*:',
                \ 'filter': ['\v\C^\s*', '', '']}
\ ]

function! ctrlp#funky#yaml#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#yaml#get_filter()
  return s:filter
endfunction

