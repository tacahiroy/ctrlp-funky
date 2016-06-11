function! ctrlp#funky#ft#proto#filters()
let filters = [
      \ { 'pattern': '\m\C^[\t ]*message\?[\t ]\+\S\+',
      \   'formatter': [] }
\ ]

return filters
endfunction
