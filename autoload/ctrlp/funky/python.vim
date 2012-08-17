" File: autoload/ctrlp/funky/python.vim
" Description: adds python support to ctrlp's funky extension
" Author: pydave
" License: the MIT License

function! ctrlp#funky#python#filter(bufnr)
  let filter = [{ 'pattern': '\v\C^\s*def\s+\w.+:',
                \ 'filter': ['\v\C^\s*', '', '']}
  \]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
