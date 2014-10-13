" Language: Ruby (ruby)
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#ft#ruby#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*def[\t ]\+\S\+',
        \   'formatter': []}
  \ ]

  if get(g:, 'ctrlp_funky_ruby_requires', 0)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*require\(_relative\)\?[\t ]\+\S\+',
          \   'formatter': [] }]
    \ )
  endif

  if get(g:, 'ctrlp_funky_ruby_classes', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*class[\t ]\+\S\+',
          \   'formatter': [] }]
    \ )
  endif

  if get(g:, 'ctrlp_funky_ruby_modules', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*module[\t ]\+\S\+',
          \   'formatter': [] }]
    \ )
  endif

  if get(g:, 'ctrlp_funky_ruby_access', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*\(private\|protected\|public\)[\t ]*$',
          \   'formatter': ['\S\+', '&', ''] }]
    \ )
  endif

  if get(g:, 'ctrlp_funky_ruby_rake_words', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*task[\t ]\+\S\+',
          \   'formatter': ['\m\C^[\t ]*', '', ''] }]
    \ )
  endif

  if get(g:, 'ctrlp_funky_ruby_chef_words', 0)
    call extend(filters, ctrlp#funky#ft#chef#filters())
  endif

  return filters
endfunction
