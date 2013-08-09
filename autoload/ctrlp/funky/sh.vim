" Language: shell script (sh)
" Author: Takahiro Yoshihara
" License: The MIT License

let shtype = get(g:, 'ctrlp_funky_sh_type', 'bash')

execute 'runtime! ctrlp/funky/' . shtype . '.vim'

if exists('*ctrlp#funky#' . shtype . '#get_filter')
  let s:filter = ctrlp#funky#{shtype}#get_filter()
else
  let s:filter = ctrlp#funky#bash#get_filter()
endif

function! ctrlp#funky#sh#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#sh#get_filter()
  return s:filter
endfunction

