" File: autoload/ctrlp/funky/default.vim
" Description: ctrlp-funky default filters
" Author: Takahiro YOSHIHARA <tacahiroy```AT```gmail.com>

function! ctrlp#funky#default#load()
  let filters = {}

  let filters.ruby = [{ 'pattern': '\m\C^[\t ]*def[\t ]\+\S\+',
                        \ 'filter': ['\m\C^[\t ]*', '', '']}
  \ ]

  let filters.vim = [{ 'pattern': '\m\C^[\t ]*fu\(n\|nc\|nct\|ncti\|nctio\|nction\)\?!\?[\t ]\+\S\+',
                      \ 'filter': ['\m\C^[\t ]*', '', '']}
  \ ]

  let filters.markdown = [{ 'pattern': '\m\C^#\{1,3}[\t ]\+\S\+',
                            \ 'filter': []},
                          \ { 'pattern': '\m\C^[-=]\{3,}$',
                          \   'filter': [],
                          \   'offset': -1}
  \ ]

  return filters
endfunction

