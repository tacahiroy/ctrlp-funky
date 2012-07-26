" File: autoload/ctrlp/funky/python.vim
" Description: adds python support to ctrlp's funky extension
" Author: pydave
" License: the MIT License

function! ctrlp#funky#python#filter(bufnr)
  let lines = getbufline(a:bufnr, 1, '$')
  let filtered = []
  let i = 1
  for line in lines
    if 0 <= match(line, '\v\C^\s*def\s+\w.+:')
      let fn = substitute(line, '\v\C^\s*', '', '')
      let bn = bufname(a:bufnr)
      call add(filtered, printf('%s #%s:%d:%d', fn, '', a:bufnr, i))
    endif
    let i += 1
  endfor
  return copy(filtered)
endfunction

" vim: fen:fdm=marker
