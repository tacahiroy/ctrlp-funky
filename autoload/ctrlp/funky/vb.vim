" Language: Visual Basic (vb)
" Author: Takahiro Yoshihara
" License: The MIT License

let s:filter = [{ 'pattern': '\v\c^[\t ]*%((Private|Friend|Public)[\t ]+)?(Function|Sub)[\t ]+',
                \ 'filter': [] },
              \ { 'pattern': '\v\c^[\t ]*%((Private|Friend|Public)[\t ]+)?(Property)[\t ]',
              \   'filter': [] }
\ ]

function! ctrlp#funky#vb#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#vb#get_filter()
  return s:filter
endfunction

