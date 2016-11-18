let s:save_cpo = &cpo
set cpo&vim

let s:TRUE = 1
let s:FALSE = 0
let &path = getcwd()

" let &runtimepath .= 
let s:sdir = expand('<sfile>:p:h')

function! s:get_expected(ft)
  return sort(readfile(printf('%s/res/%s.lst', s:sdir, a:ft)))
endfunction

function! s:msgf(msg)
    echoerr 'Assertion failed!!'
    echoerr a:msg
endfunction

function! s:value(name, s)
  echomsg printf('## %s == %s', a:name, a:s)
endfunction

function! s:assert(actual, expected)
  let a = a:actual
  let e = a:expected
  let is_err = s:FALSE

  if type(a) != type(e)
    call s:msgf('Type of actual is different from expected.')
    let is_err = s:TRUE
  endif

  if len(a) != len(e)
    call s:msgf('Length of actual is different from expected.')
    let is_err = s:TRUE
  endif

  if a != e
    call s:msgf('Contents of actual is different from expected.')
    let is_err = s:TRUE
  endif

  if is_err == s:TRUE
    call s:value('expected', string(e))
    call s:value('actual', string(a))
    return s:FALSE
  endif

  return s:TRUE
endfunction

" Get function definitions
function! s:funcd(bufnr)
  let actual = sort(ctrlp#funky#init(a:bufnr))
  call map(actual, 'substitute(v:val, "[\t ]*\t#:\\d\\+:\\d\\+$", "", "")')
  return actual
endfunction

function! s:run_test(ft)
  if !exists('s:mainwin')
    let s:mainwin = winnr()
  endif
  let s:mainwin = winnr()

  let ext = s:ft2ext(a:ft)
  " Open a test file
  execute printf('sil find! %s/res/%s.%s', s:sdir, a:ft, ext)
  let bufnr = bufnr('')
  let &l:filetype = a:ft
  execute 'buffer ' . s:mainwin

  " candidates => actual
  " Get expected list
  let expected = s:get_expected(a:ft)
  let actual = s:funcd(bufnr)

  " Assert expected == actual
  if s:assert(actual, expected)
    echomsg printf('* %s = %s', a:ft, 'OK')
  endif
endfunction

function! s:ft2ext(filetype)
  let types = {
        \ 'clojure':    'clj',
        \ 'cpp':        'cpp',
        \ 'cs':         'cs',
        \ 'elixir':     'ex',
        \ 'javascript': 'js',
        \ 'jinja': 'html',
        \ 'haskell':    'hs',
        \ 'make':       '',
        \ 'python':     'py',
        \ 'ruby':       'rb',
\ }

  return get(types, a:filetype, a:filetype)
endfunction

function! TestAll()
  RunTest javascript
  RunTest c
endfunction

command! -nargs=1 RunTest call <SID>run_test(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
