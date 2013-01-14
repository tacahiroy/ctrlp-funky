" File: autoload/ctrlp/funky.vim
" Description: a simple ctrlp.vim extension provides jumping to function
" Version: 0.3.0
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: the MIT License

let s:saved_cpo = &cpo
set cpo&vim

let s:is_all_buffers = get(g:, 'ctrlp_funky_all_buffers', 0)
let s:report_filter_error = get(g:, 'ctrlp_funky_report_filter_error', 0)

" The main variable for this extension.
"
" The values are:
" + the name of the input function (including the brackets and any argument)
" + the name of the action function (only the name)
" + the long and short names to use for the statusline
" + the matching type: line, path, tabs, tabe
"                      |     |     |     |
"                      |     |     |     `- match last tab delimited str
"                      |     |     `- match first tab delimited str
"                      |     `- match full line like file/dir path
"                      `- match full line
call add(g:ctrlp_ext_vars, {
  \ 'init':   'ctrlp#funky#init(s:crbufnr)',
  \ 'accept': 'ctrlp#funky#accept',
  \ 'lname':  'Funky',
  \ 'sname':  'funky',
  \ 'type':   'line',
  \ 'sort': 0
  \ })

function! s:syntax()
  if !ctrlp#nosy()
    call ctrlp#hicheck('CtrlPBufName', 'Directory')
    call ctrlp#hicheck('CtrlPTabExtra', 'Comment')
    syn match CtrlPBufName '\t#\zs\S\+\ze:\d\+:\d\+$'
    syn match CtrlPTabExtra '\zs\t.*\ze$' contains=CtrlPBufName
  endif
endfunction

function! s:filetypes(bufnr)
  return split(getbufvar(a:bufnr, '&l:filetype'), '\.')
endfunction

function! s:clear_open_func()
  if has_key(g:ctrlp_open_func, 'Funky')
    call remove(g:ctrlp_open_func, 'Funky')
  endif
endfunction

" Provide a list of strings to search in
"
" Return: List
function! ctrlp#funky#init(bufnr)
  let bufs = []
  if s:is_all_buffers
    for bn in ctrlp#allbufs()
      call add(bufs, bufnr(bn))
    endfor
  else
    let bufs = [a:bufnr]
  endif

  let saved_ei = &eventignore
  let &eventignore = 'BufLeave'

  let ctrlp_winnr = bufwinnr(bufnr(''))
  execute bufwinnr(a:bufnr) . 'wincmd w'
  let pos = getpos('.')

  let candidates = []
  for bufnr in bufs
    for ft in s:filetypes(bufnr)
      if s:has_filter(ft)
        call s:clear_open_func()
        " use function
        let candidates += ctrlp#funky#{ft}#filter(bufnr)
      elseif s:report_filter_error
        echoerr ft.': filter does not exist'
      endif
    endfor
  endfor

  call setpos('.', pos)

  execute ctrlp_winnr . 'wincmd w'
  call s:syntax()
  let &eventignore = saved_ei

  return candidates
endfunction

function! s:has_filter(ft)
  let func = 'autoload/ctrlp/funky/'.a:ft.'.vim'
  return !empty(globpath(&runtimepath, func))
endfunction

function! ctrlp#funky#abstract(bufnr, patterns)
  try
    let candidates = []
    let ctrlp_winnr = bufwinnr(bufnr(''))

    execute bufwinnr(a:bufnr) . 'wincmd w'

    for c in a:patterns
      let offset = get(c, 'offset', 0)

      redir => ilist
        execute 'silent! global/' . c.pattern . '/echo printf("%s \t#%s:%d:%d", getline(line(".") + offset), bufname(a:bufnr), a:bufnr, line(".") + offset)'
      redir END

      if ilist !~# '\nE486:'
        if empty(c.filter)
          let candidates += split(ilist, '\n')
        else
          for l in split(ilist, '\n')
            call add(candidates, substitute(l, c.filter[0].'\ze \t#', c.filter[1], c.filter[2]))
          endfor
        endif
      endif
    endfor

    return candidates
  finally
    execute ctrlp_winnr . 'wincmd w'
  endtry
endfunction

" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
function! ctrlp#funky#accept(mode, str)
  let [bufnr, lnum] = matchlist(a:str, '\m\C#.*:\(\d\+\):\(\d\+\)$')[1:2]
  let bufname = bufname(str2nr(bufnr, 10))

  " supports no named buffer
  if empty(bufname)
    call ctrlp#exit()
    call ctrlp#funky#goto_line(a:mode, a:str)
  else
    let fpath = fnamemodify(bufname, ':p')
    call ctrlp#acceptfile(a:mode, fpath, lnum)
  endif
endfunction

function! ctrlp#funky#goto_line(action, line)
  call ctrlp#exit()
  let bufnum = matchstr(a:line, '\d\+\ze:\d\+$')
  let lnum = matchstr(a:line, '\d\+$')
  call setpos('.', [bufnum, lnum, 1, 0])
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
function! ctrlp#funky#id()
  return s:id
endfunction

" Create a command to directly call the new search type.
"
" Put something like this in vimrc or plugin/funky.vim
" com! CtrlPFunky cal ctrlp#init(ctrlp#funky#id())

let &cpo = s:saved_cpo

" vim:fen:fdl=0:ts=2:sw=2:sts=2
