" Description: adds ruby support to ctrlp's funky extension
" Language: Ruby
" Author: Takahiro YOSHIHARA
" License: The MIT License

let s:filter = [{ 'pattern': '\m\C^[\t ]*def[\t ]\+\S\+',
                \ 'filter': []}
\ ]

if get(g:, 'ctrlp_funky_ruby_requires', 0)
  call extend(s:filter, [{ 'pattern': '\m\C^[\t ]*require\(_relative\)\?[\t ]\+\S\+',
                         \ 'filter': []}])
endif

if get(g:, 'ctrlp_funky_ruby_classes', 1)
  call extend(s:filter, [{ 'pattern': '\m\C^[\t ]*class[\t ]\+\S\+',
                         \ 'filter': []}])
endif

if get(g:, 'ctrlp_funky_ruby_modules', 1)
  call extend(s:filter, [{ 'pattern': '\m\C^[\t ]*module[\t ]\+\S\+',
                         \ 'filter': []}])
endif

if get(g:, 'ctrlp_funky_ruby_rake_words', 1)
  call extend(s:filter, [{ 'pattern': '\m\C^[\t ]*task[\t ]\+\S\+',
                         \ 'filter': ['\m\C^[\t ]*', '', '']}])
endif

if get(g:, 'ctrlp_funky_ruby_chef_words', 0)
  echom string(ctrlp#funky#chef#get_filter())
  call extend(s:filter, ctrlp#funky#chef#get_filter())
endif

function! ctrlp#funky#ruby#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#ruby#get_filter()
  return s:filter
endfunction

