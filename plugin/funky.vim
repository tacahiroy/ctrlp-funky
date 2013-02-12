" File: plugin/funky.vim
" Description: a simple ctrlp.vim extension provides jumping to function
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

if exists('g:loaded_ctrlp_funky') || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_funky = 1

let s:saved_cpo = &cpo
set cpo&vim

command! CtrlPFunky call ctrlp#init(ctrlp#funky#id())

let g:ctrlp_open_func = get(g:, 'ctrlp_open_func', {})

let &cpo = s:saved_cpo
unlet s:saved_cpo

