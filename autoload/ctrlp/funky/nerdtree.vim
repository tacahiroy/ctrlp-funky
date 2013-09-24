" Language: The NERD tree (nerdtree)
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#nerdtree#filters()
  let filters = [
        \ { 'pattern': '\m\C^\s*[▸▾|~+].*\/$',
        \   'formatter': [] }
  \ ]

  " useful?
  if get(g:, 'ctrlp_funky_nerdtree_include_files', 0)
    call add(filters,
          \ { 'pattern': '\m\C^\s\+.\+$',
          \   'formatter': [] }
    \ )
  endif

  return filters
endfunction
