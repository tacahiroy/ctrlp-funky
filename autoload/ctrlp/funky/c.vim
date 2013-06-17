" Language: C
" Author: pydave
" Author: unc0
" License: The MIT License

" c is too hard to parse (and style varies wildly), so just look for
" something that starts in the first column, has brackets, and the
" first bracket is preceeded by a word. If you put a space before your
" functions, then you're out of luck because this eliminates most text
" false positives.
let s:filter = [{ 'pattern': '^\w.*\s*\w(',
                \ 'filter': []}
                \ ]

function! ctrlp#funky#c#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#c#get_filter()
  return s:filter
endfunction
