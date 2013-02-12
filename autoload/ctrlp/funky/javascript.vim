" File: autoload/ctrlp/funky/javascript.vim
" Description: adds javascript support to ctrlp's funky extension
" Author: curist
" License: The MIT License

let s:filter = [{ 'pattern': '\v\s*function\s+\w.+\s*\(',
              \   'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']},
              \ { 'pattern': '\v\C\w.+\s*\=\s*function\s*\(',
              \   'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']}
\]

function! ctrlp#funky#javascript#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#javascript#get_filter()
  return s:filter
endfunction

