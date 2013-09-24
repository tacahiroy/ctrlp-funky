" Language: Markdown (markdown)
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#markdown#filters()
  let filters = [
        \ { 'pattern': '\m\C^#\{1,3}[\t ]\+\S\+',
        \   'formatter': [] },
        \ { 'pattern': '\m\C^[-=]\{3,}$',
        \   'formatter': [],
        \   'offset': -1 }
  \ ]
  return filters
endfunction
