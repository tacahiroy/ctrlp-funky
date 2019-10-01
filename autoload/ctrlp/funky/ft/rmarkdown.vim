" Language: Rmarkdown (rmd)
" Author: Cenk Soykan
" License: The MIT License

function! ctrlp#funky#ft#rmarkdown#filters()
  let filters = [
        \ { 'pattern': '\m\C^#\{1,6}[\t ]\+\S\+',
        \   'formatter': [] },
        \ { 'pattern': '\m\C^[-=]\{3,}$',
        \   'formatter': [],
        \   'offset': -1 }
  \ ]
  return filters
endfunction
