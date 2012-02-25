" File: autoload/ctrlp/thefunks.vim
" Description: a ctrlp.vim extension provides jumping to function
" Author: Takahiro YOSHIHARA <tacahiroy```AT```gmail.com>

if exists('g:loaded_ctrlp_thefunks') || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_thefunks = 1

let s:ctrlp_thefunks_all_buffers = get(g:, 'ctrlp_thefunks_all_buffers', 0)
let s:ctrlp_thefunks_report_filter_error =
      \ get(g:, 'ctrlp_thefunks_report_filter_error', 0)

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
let s:thefunks_var = {
	\ 'init':   'ctrlp#thefunks#init(s:crbufnr)',
	\ 'accept': 'ctrlp#thefunks#accept',
	\ 'lname':  'Dory & Terry',
	\ 'sname':  'funks',
	\ 'type':   'line',
	\ }

" Append s:thefunks_var to g:ctrlp_ext_vars
if exists('g:ctrlp_ext_vars')
	let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:thefunks_var)
else
	let g:ctrlp_ext_vars = [s:thefunks_var]
endif


" Provide a list of strings to search in
"
" Return: a Vim's List
function! ctrlp#thefunks#init(bufnr)
  let bufs = []
  if s:ctrlp_thefunks_all_buffers
    for bn in ctrlp#allbufs()
      call add(bufs, bufnr(bn))
    endfor
  else
    let bufs = [a:bufnr]
  endif

  let candidates = []
  for bufnr in bufs
    let ft = getbufvar(bufnr, '&l:filetype')
    if !s:has_filter(ft)
      if s:ctrlp_thefunks_report_filter_error
        echoerr ft.': filter does not exist'
      endif
      continue
    endif

    let lines = ctrlp#thefunks#{ft}#filter(bufnr)
    for l in lines
      call add(candidates, l)
    endfor
  endfor

  return candidates
endfunction

function! s:has_filter(ft)
  let func = 'autoload/ctrlp/thefunks/'.a:ft.'.vim'
  return !empty(globpath(&runtimepath, func))
endfunction


" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
function! ctrlp#thefunks#accept(mode, str)
  let [bufnr, lnum] = matchlist(a:str, '\m\C#.*:\(\d\+\):\(\d\+\)$')[1:2]
  let fpath = fnamemodify(bufname(str2nr(bufnr, 10)), ':p')
	call ctrlp#acceptfile(a:mode, fpath, lnum)
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
function! ctrlp#thefunks#id()
	return s:id
endfunction

" Create a command to directly call the new search type.
"
" Put something like this in vimrc or plugin/thefunks.vim
" com! CtrlPTheFunks cal ctrlp#init(ctrlp#thefunks#id())


" vim:fen:fdl=0:ts=2:sw=2:sts=2
