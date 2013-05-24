" Language: Objective-C (objc)
" Author: tokorom
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^\(-\|+\)\s*(\S\+)\s*.*',
                \ 'filter': []}
\ ]

" Add the filter for cpp
call extend(s:filter, ctrlp#funky#cpp#get_filter())

function! ctrlp#funky#objc#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#objc#get_filter()
  return s:filter
endfunction

