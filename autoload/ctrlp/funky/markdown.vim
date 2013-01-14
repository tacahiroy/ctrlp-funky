" File: autoload/ctrlp/funky/markdown.vim
" Description: adds markdown support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: the MIT License

function! ctrlp#funky#markdown#filter(bufnr)
  let filter = [{ 'pattern': '\m\C^#\{1,3}[\t ]\+\S\+',
                \ 'filter': []}]
  call add(filter, { 'pattern': '\m\C^[-=]\{3,}$',
                    \   'filter': [],
                    \   'offset': -1})

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
