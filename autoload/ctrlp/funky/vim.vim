" File: autoload/ctrlp/funky/vim.vim
" Description: a ctrlp.vim extension thenfunky's filter definition (vim)
" Author: Takahiro YOSHIHARA <tacahiroy```AT```gmail.com>
" License: the MIT License
" Copyright 2012 Takahiro YOSHIHARA"{{{
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
" 
" The software is provided "as is", without warranty of any kind, express or
" implied, including but not limited to the warranties of merchantability,
" fitness for a particular purpose and noninfringement. In no event shall the
" authors or copyright holders be liable for any claim, damages or other
" liability, whether in an action of contract, tort or otherwise, arising from,
" out of or in connection with the software or the use or other dealings in the
" software."}}}

function! ctrlp#funky#vim#filter(bufnr)
  let lines = getbufline(a:bufnr, 1, '$')
  let filtered = []
  let i = 1
  for l in lines
    if 0 <= match(l, '\m\C^[\t ]*fu\(n\|nc\|nct\|ncti\|nctio\|nction\)\?!\?[\t ]\+\S\+')
      let fn = substitute(l, '\m\C^[\t ]*', '', '')
      let bn = bufname(a:bufnr)
      call add(filtered, printf('%s #%s:%d:%d', fn, '', a:bufnr, i))
    endif
    let i += 1
  endfor
  return copy(filtered)
endfunction

" vim: fen:fdm=marker
