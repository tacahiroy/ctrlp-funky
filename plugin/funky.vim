" File: plugin/funky.vim
" Description: a simple ctrlp.vim extension provides jumping to function
" Version: 0.2.0
" Author: Takahiro YOSHIHARA <tacahiroy```AT```gmail.com>

if exists('g:loaded_ctrlp_funky') || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_funky = 1

let s:saved_cpo = &cpo
set cpo&vim

command! CtrlPFunky call ctrlp#init(ctrlp#funky#id())

let &cpo = s:saved_cpo

