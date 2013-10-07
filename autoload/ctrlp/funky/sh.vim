" Language: shell script (sh)
" Author: Takahiro Yoshihara
" License: The MIT License

function! s:is_valid_sh_type(shtype)
  " shtype is not a kinda shell
  if exists('*ctrlp#funky#' . a:shtype . '#is_kinda_sh')
    return ctrlp#funky#{a:shtype}#is_kinda_sh()
  else
    return 0
  endif
endfunction

function! ctrlp#funky#sh#filters()
  let shtype = get(g:, 'ctrlp_funky_sh_type', 'bash')

  " note: like this code is very slow: runtime! ctrlp/funky/{shtype}.vim
  execute 'runtime! ctrlp/funky/' . shtype . '.vim'

  " shtype is not kind of a shell
  if !s:is_valid_sh_type(shtype)
    let shtype = 'bash'
  endif

  if exists('*ctrlp#funky#' . shtype . '#filters')
    return ctrlp#funky#{shtype}#filters()
  else
    return ctrlp#funky#bash#filters()
  endif
endfunction
