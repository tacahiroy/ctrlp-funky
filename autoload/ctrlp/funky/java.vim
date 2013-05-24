" Language: Java (java)
" Author: pydave
" License: The MIT License

" Java has a mostly standard format and style, so assume we've got
" everything on one line (excluding annotations).
let regex = '\v^\s+'                " preamble
let regex .= '%(<\w+>\s+){0,3}'     " visibility, static, final
let regex .= '%(\w|[<>[\]])+\s+'    " return type
let regex .= '\w+\s*'               " method name
let regex .= '\([^\)]*\)'           " method parameters
let regex .= '%(\w|\s|\{)+$'        " postamble

let s:filter = [{ 'pattern': regex,
                \ 'filter': ['\v(^\s*)|(\s*\{.*\ze \t#)', '', 'g']}
\ ]

function! ctrlp#funky#java#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#java#get_filter()
  return s:filter
endfunction

