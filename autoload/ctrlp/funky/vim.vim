" Language: Vim script (vim)
" Author: Takahiro Yoshihara
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^[\t ]*fu\(n\|nc\|nct\|ncti\|nctio\|nction\)\?!\?[\t ]\+\S\+',
                \ 'filter': ['\m\C^[\t ]*', '', '']}
\]

function! ctrlp#funky#vim#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#vim#get_filter()
  return s:filter
endfunction

