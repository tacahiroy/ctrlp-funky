" Language: Crystal (crystal)
" Author: phongnh <nhphong1406@gmail.com>
" License: The MIT License

let s:pat = {}

function! ctrlp#funky#ft#crystal#filters()
  let s:pat.method = '\m\C^[\t ]*def[\t ]\+\(\w\+\)'

  let filters = [
        \ { 'pattern': s:pat.method,
        \   'formatter': []}
        \ ]

  if get(g:, 'ctrlp_funky_crystal_requires', 0)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*require[\t ]\+\S\+',
          \   'formatter': [] }]
          \ )
  endif

  if get(g:, 'ctrlp_funky_crystal_classes', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*class[\t ]\+\S\+',
          \   'formatter': [] }]
          \ )
  endif

  if get(g:, 'ctrlp_funky_crystal_modules', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*module[\t ]\+\S\+',
          \   'formatter': [] }]
          \ )
  endif

  if get(g:, 'ctrlp_funky_crystal_structs', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*struct[\t ]\+\S\+',
          \   'formatter': [] }]
          \ )
  endif

  if get(g:, 'ctrlp_funky_crystal_enums', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*enum[\t ]\+\S\+',
          \   'formatter': [] }]
          \ )
  endif

  if get(g:, 'ctrlp_funky_crystal_spec', 1)
    call extend(filters, [
          \ { 'pattern': '\m\C^[\t ]*\(describe\|it\)[\t ]\+\S\+',
          \   'formatter': [] }]
          \ )
  endif

  return filters
endfunction

" Tells how to strip clothes
function! ctrlp#funky#ft#crystal#strippers()
  return [ {'pattern': s:pat.method, 'position': 1 } ]
endfunction
