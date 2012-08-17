" File: autoload/ctrlp/funky/ruby.vim
" Description: adds ruby support to ctrlp's funky extension
" Author: Takahiro YOSHIHARA
" License: the MIT License

function! ctrlp#funky#ruby#filter(bufnr)
  let filter = [{ 'pattern': '\m\C^[\t ]*def[\t ]\+\S\+',
                \ 'filter': ['\m\C^[\t ]*', '', '']}
  \ ]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
