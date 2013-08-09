" Language: Debian Almquist shell (dash)
" Author: Takahiro Yoshihara
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^[\t ]*\([\t ]\+\)*[_a-zA-Z][_a-zA-Z0-9]\+[\t ]*\(([\t ]*)\)\?[\t ]*\n*{',
                \ 'filter': []}
\]

function! ctrlp#funky#dash#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#dash#get_filter()
  return s:filter
endfunction

