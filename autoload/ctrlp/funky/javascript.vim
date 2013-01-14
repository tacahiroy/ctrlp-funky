" File: autoload/ctrlp/funky/javascript.vim
" Description: adds javascript support to ctrlp's funky extension
" Author: curist
" License: the MIT License

function! ctrlp#funky#javascript#filter(bufnr)
  let filter = [{ 'pattern': '\v\s*function\s+\w.+\s*\(',
                \ 'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']},
                \ { 'pattern': '\v\C\w.+\s*\=\s*function\s*\(',
                \   'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']}
  \]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
