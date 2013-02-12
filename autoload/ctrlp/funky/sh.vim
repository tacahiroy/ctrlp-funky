" File: autoload/ctrlp/funky/sh.vim
" Description: adds sh support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

function! ctrlp#funky#sh#filter(bufnr)
  let filter = [{ 'pattern': '\m\C^[\t ]*\(function \)\?[_a-zA-Z][_a-zA-Z0-9]\+([\t ]*)[\t ]*{',
                \ 'filter': ['\m\C([\t ]*)[\t ]*{', '', '']}
  \]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

