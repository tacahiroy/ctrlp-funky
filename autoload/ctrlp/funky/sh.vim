" Language: shell script (sh)
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#sh#filters()
  let shtype = get(g:, 'ctrlp_funky_sh_type', 'bash')

  " note: like this code is very slow: runtime! ctrlp/funky/{shtype}.vim
  execute 'runtime! ctrlp/funky/' . shtype . '.vim'

  if exists('*ctrlp#funky#' . shtype . '#filters')
    return ctrlp#funky#{shtype}#filters()
  else
    return ctrlp#funky#bash#filters()
  endif
endfunction
