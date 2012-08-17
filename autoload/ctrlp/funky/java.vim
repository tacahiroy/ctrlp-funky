" File: autoload/ctrlp/funky/java.vim
" Description: adds Java support to ctrlp's funky extension
" Author: pydave
" License: the MIT License

function! ctrlp#funky#java#filter(bufnr)
  " Java has a mostly standard format and style, so assume we've got
  " everything on one line (excluding annotations).
  let regex = '\v^\s+'                " preamble
  let regex .= '%(<\w+>\s+){0,3}'     " visibility, static, final
  let regex .= '%(\w|[<>[\]])+\s+'    " return type
  let regex .= '\w+\s*'               " method name
  let regex .= '\([^\)]*\)'           " method parameters
  let regex .= '%(\w|\s|\{)+$'           " postamble

  let filter = [{ 'pattern': regex,
                \ 'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']}
  \ ]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
