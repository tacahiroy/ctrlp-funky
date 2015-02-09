" Language: TypeScript (typescript)
" Author: prabirshrestha
" License: The MIT License

function! ctrlp#funky#ft#typescript#filters()
 let filters = [
        \ { 'pattern': '\v\s*((module)|(class)|(interface)|(enum))\s+\w+.*\{',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
