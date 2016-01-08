" Language: Clojure
" Author: curist
" License: The MIT License

function! ctrlp#funky#ft#clojure#filters()
  " matches (def) and (defn)
  let filters = [
        \ { 'pattern': '^(def\(n-\?\)\?[\t ]\+\D.*',
        \   'formatter': [] }
  \ ]
  return filters
endfunction
