" File: autoload/ctrlp/funky.vim
" Description: a simple ctrlp.vim extension provides jumping to a function
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

if get(g:, 'loaded_ctrlp_funky', 0)
  finish
endif
let g:loaded_ctrlp_funky = 1

let s:saved_cpo = &cpo
set cpo&vim

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
  \ 'lname':  'funky',
  \ 'sname':  'fky',
  \ 'type':   'line',
  \ 'exit':  'ctrlp#funky#exit()',
  \ 'nolim':  1,
  \ 'sort':   0
  \ })

" Object: s:mru {{{
let s:mru = {}
let s:mru.buffers = {}

function! s:mru.index(bufnr, def)
  if !has_key(self.buffers, a:bufnr) | return -1 | endif
  return index(self.buffers[a:bufnr], a:def)
endfunction

function! s:mru.prioritise(bufnr, def)
  let pos = self.index(a:bufnr, a:def)
  if pos >= 0
    call remove(self.buffers[a:bufnr], pos)
  endif
  call insert(self.buffers[a:bufnr], a:def, 0)
endfunction
" }}}

" Object: s:filters {{{
let s:filters = {}
let s:filters.filetypes = {}

function! s:filters.is_cached(ft)
  return has_key(self.filetypes, a:ft)
endfunction

function! s:filters.load(ft)
  return self.filetypes[a:ft]
endfunction

function! s:filters.save(ft, filters)
  let self.filetypes[a:ft] = a:filters
endfunction
" }}}

" Object: s:cache {{{
let s:cache = {}
let s:cache.list = {}

function! s:cache.save(bufnr, defs)
  let h = s:timesize(a:bufnr)
  let fname = s:fname(a:bufnr)
  " save function defs
  let self.list[fname] = extend([h], a:defs)
  call writefile(self.list[fname], s:build_path(s:cache_dir, s:conv_sp(fname)))
endfunction

function! s:cache.load(bufnr)
  call self.read(a:bufnr)
  " first line is hash value
  return self.list[s:fname(a:bufnr)][1:-1]
endfunction

function! s:cache.path(fname)
  return s:build_path(s:cache_dir, s:conv_sp(a:fname))
endfunction

function! s:cache.read(bufnr)
  let fname = s:fname(a:bufnr)
  let cache_file = self.path(fname)
  if empty(get(self.list, fname, {}))
    let self.list[fname] = []
    if filereadable(cache_file)
      let self.list[fname] = readfile(cache_file)
    endif
  endif
endfunction

function! s:cache.is_maybe_unchanged(bufnr)
  if !s:is_real_file(a:bufnr) | return 0 | endif
  let prev = self.timesize(a:bufnr)
  let cur = s:timesize(a:bufnr)
  call s:debug(prev . ' = ' . cur . ': ' . (prev == cur ? 'same' : 'diff'))
  return prev == cur
endfunction

function! s:cache.timesize(bufnr)
  call self.read(a:bufnr)
  let fname = s:fname(a:bufnr)
  return get(get(self.list, fname, []), 0, '')
endfunction
" }}}

" script funcs {{{
" TODO: some functions should be defined under ctrlp#funky#utils namespace
function! s:syntax(filetype)
  if !ctrlp#nosy()
    call ctrlp#hicheck('CtrlPTabExtra', 'Comment')
    syn match CtrlPTabExtra '\t#.*:\d\+:\d\+$'

    for [k,v] in items(s:custom_hl_list)
      call ctrlp#hicheck(k, v.to_group)
      execute printf('syn match %s "%s"', k, v.pat)
    endfor

    if s:syntax_highlight | let &filetype = a:filetype | endif
  endif
endfunction

function! s:error(msg)
    echohl ErrorMsg | echomsg a:msg | echohl NONE
    let v:errmsg  = a:msg
endfunction

function! s:is_real_file(bufnr)
  if &buftype =~# '\v^(nofile|quickfix|help)$' | return 0 | endif
  let path = fnamemodify(bufname(a:bufnr), ':p')
  call s:debug(path . ': ' . filereadable(path))
  return filereadable(path)
endfunction

function! s:debug(msg)
  if s:debug | echomsg '[DEBUG]' . string(a:msg) | endif
endfunction

function! s:filetype(bufnr)
  return getbufvar(a:bufnr, '&l:filetype')
endfunction

function! s:has_filter(ft)
  let func = 'autoload/ctrlp/funky/' . a:ft . '.vim'
  return !empty(globpath(&runtimepath, func))
endfunction

function! s:has_post_extract_hook(ft)
  return exists('*ctrlp#funky#' . a:ft . '#post_extract_hook')
endfunction

function! s:filters_by_filetype(ft, bufnr)
  let filters = []

  if s:filters.is_cached(a:ft)
    return s:filters.load(a:ft)
  else
    " NOTE: new API since v0.6.0
    let filters = ctrlp#funky#{a:ft}#filters()
  endif

  call s:filters.save(a:ft, filters)

  return filters
endfunction

" It does an action after jump to a definition such as 'zxzz'
" In most of cases, this is used for opening folds.
"
function! s:after_jump()
  let pattern = '^\m\C\(z[xoOv]\)\?\(z[zt]\)\?$'

  " parse setting.
  if empty(s:after_jump)
    return
  elseif type(s:after_jump) == type('')
    let action = s:after_jump
  elseif type(s:after_jump) == type({})
    let action = get(s:after_jump, &filetype,
                                 \ get(s:after_jump, 'default', 'zxzz')
    \ )
  else
    echoerr 'Invalid type for g:ctrlp_funky_after_jump, need a string or dict'
    return
  endif

  if empty(action) | return | endif

  " verify action string pattern.
  if action !~ pattern
    echoerr 'Invalid content in g:ctrlp_funcky_after_jump, need "z[xov]z[zt]"'
    return
  else
    let matched = matchlist(action, pattern)
    let [foldview, scrolling] = matched[1:2]
  endif

  if !&foldenable || foldlevel(line('.')) == 0
    let action = scrolling
  endif

  silent! execute 'normal! ' . action . '0'
endfunction

function! s:fname(bufnr, ...)
  let path = fnamemodify(bufname(a:bufnr), ':p')
  if a:0
    if a:1 == 'f'
      " file name only
      return fnamemodify(path, ':p:t')
    elseif a:1 == 'd'
      " dir name only
      return fnamemodify(path, ':p:h')
    endif
  endif
  return path
endfunction

function! s:ftime(bufnr)
  return getftime(s:fname(a:bufnr))
endfunction

function! s:fsize(bufnr)
  return getfsize(s:fname(a:bufnr))
endfunction

function! s:timesize(bufnr)
  return string(s:ftime(a:bufnr)) . string(s:fsize(a:bufnr))
endfunction

function! s:is_windows()
  return has('win32') || has('win64')
endfunction

function! s:build_path(...)
  if a:0 == 0 | return '' | endif
  let sp = '/'
  if s:is_windows()
    if exists('+shellslash')
      let sp = (&shellslash ? '/' : '\')
    endif
  endif
  return join(a:000, sp)
endfunction

function! s:conv_sp(name)
  return substitute(a:name, '[\/:]', '%', 'g')
endfunction
" }}}

" Provide a list of strings to search in
"
" Return: List
function! ctrlp#funky#init(bufnr)
  try
    let saved_ei = &eventignore
    let &eventignore = 'BufLeave'

    let ctrlp_winnr = bufwinnr(bufnr(''))
    execute bufwinnr(a:bufnr) . 'wincmd w'
    let pos = getpos('.')
    let filetype = s:filetype(a:bufnr)

    let candidates = []
    for ft in split(filetype, '\.')
      if s:has_filter(ft)
        let filters = s:filters_by_filetype(ft, a:bufnr)
        let st = reltime()
        let candidates += ctrlp#funky#extract(a:bufnr, filters)
        call s:debug('Extract: ' . reltimestr(reltime(st)))
        if s:has_post_extract_hook(ft)
          call ctrlp#funky#{ft}#post_extract_hook(candidates)
        endif
      elseif s:report_filter_error
        echoerr printf('%s: filters not exist', ft)
      endif
    endfor

    call setpos('.', pos)

    execute ctrlp_winnr . 'wincmd w'
    call s:syntax(filetype)

    return candidates
  finally
    let &eventignore = saved_ei
  endtry
endfunction

function! ctrlp#funky#funky(word)
  let s:winnr = winnr()
  try
    if !empty(a:word)
      let default_input_save = get(g:, 'ctrlp_default_input', '')
      let g:ctrlp_default_input = a:word
    endif

    call ctrlp#init(ctrlp#funky#id())
  finally
    if exists('default_input_save')
      let g:ctrlp_default_input = default_input_save
    endif
  endtry
endfunction

" todo: needs to improved. 'if s:sort_by_mru' too much
function! ctrlp#funky#extract(bufnr, patterns)
  try
    let candidates = []
    let ctrlp_winnr = bufwinnr(bufnr(''))

    if s:sort_by_mru && !has_key(s:mru.buffers, a:bufnr)
      let s:mru.buffers[a:bufnr] = []
    endif

    " the file hasn't been changed since cached
    if s:use_cache && s:is_real_file(a:bufnr) && s:cache.is_maybe_unchanged(a:bufnr)
      let ca = s:cache.load(a:bufnr)
      if s:sort_by_mru
        let prior = []
        for v in s:mru.buffers[a:bufnr]
          let pos = match(ca, '\m' . escape(v, '[]') . '\t#')
          if pos >= 0
            call add(prior, get(ca, pos, []))
            call remove(ca, pos)
          endif
        endfor
        let ca = prior + ca
        call s:cache.save(a:bufnr, ca)
      endif
      return ca
    endif

    execute bufwinnr(a:bufnr) . 'wincmd w'

    let mru = []

    for c in a:patterns
      let offset = get(c, 'offset', 0)

      redir => ilist
        " using global is fast enough
        execute 'silent! global/' . c.pattern . '/echo printf("%s \t#%s:%d:%d", getline(line(".") + offset), "", a:bufnr, line(".") + offset)'
      redir END

      if ilist !~# '\n\(E486: \)\?Pattern not found:'
        for l in split(ilist, '\n')
          if l =~# '^ \t#:\d\+:\d\+$'
            continue
          endif
          let [left, right] = split(l, '\ze \t#:\d\+:\d\+')
          let formatter = c.formatter
          let [pat, str, flags] = [get(formatter, 0, ''), get(formatter, 1, ''), get(formatter, 2, '')]
          let filtered = substitute(left, pat, str, flags) . right

          if s:sort_by_mru
            let pos = s:mru.index(a:bufnr, s:definition(filtered))
          endif

          if s:sort_by_mru && pos >= 0
            " To show top of the ctrlp buffer
            call add(mru, [ filtered, pos ])
          else
            call add(candidates, filtered)
          endif
        endfor
      endif
    endfor

    let sorted = sort(candidates, function('s:sort_candidates'))
    let prior = map(sort(mru, function('s:sort_mru')), 'v:val[0]')

    if s:use_cache && s:is_real_file(a:bufnr)
      call s:cache.save(a:bufnr, prior + sorted)
    endif

    return prior + sorted
  finally
    execute ctrlp_winnr . 'wincmd w'
  endtry
endfunction

function! s:definition(line)
  return matchstr(a:line, '^.*\ze\t#')
endfunction

function! s:buflnum(line)
  return matchstr(a:line, '\zs\t#.\+$')
endfunction

function! s:sort_candidates(a, b)
  let line1 = str2nr(matchstr(a:a, '\d\+$'), 10)
  let line2 = str2nr(matchstr(a:b, '\d\+$'), 10)
  return line1 == line2 ? 0 : line1 > line2 ? 1 : -1
endfunction

function! s:sort_mru(a, b)
  let a = a:a
  let b = a:b
  return a[1] == b[1] ? 0 : a[1] > b[1] ? 1 : -1
endfunction

" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
function! ctrlp#funky#accept(mode, str)
  " always back to former window
  call ctrlp#exit()

  let bufnr = matchstr(a:str, '\d\+\ze:\d\+$')
  let lnum = matchstr(a:str, '\d\+$')
  execute get(s:, 'winnr', 1) . 'wincmd w'
  call setpos('.', [bufnr, lnum, 1, 0])

  call s:after_jump()

  if !s:sort_by_mru | return | endif

  call s:mru.prioritise(bufnr, s:definition(a:str))
endfunction

function!ctrlp#funky#exit()
  if !empty(s:errmsg) | call s:error(s:errmsg) | endif
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
function! ctrlp#funky#id()
  return s:id
endfunction

function! ctrlp#funky#highlight(pat, from_group, to_group)
  let s:custom_hl_list[a:from_group] = { 'pat': a:pat, 'to_group': a:to_group }
endfunction

""
" Configuration
"

let s:errmsg = ''

let s:report_filter_error = get(g:, 'ctrlp_funky_report_filter_error', 0)
let s:winnr = -1
let s:sort_by_mru = get(g:, 'ctrlp_funky_sort_by_mru', 0)
" after jump action
let s:after_jump = get(g:, 'ctrlp_funky_after_jump', 'zxzz')
" 1: set the same filetype as source buffer
let s:syntax_highlight = get(g:, 'ctrlp_funky_syntax_highlight', 0)

let s:use_cache = get(g:, 'ctrlp_funky_use_cache', 0)
if s:use_cache
  let s:cache_dir = get(g:, 'ctrlp_funky_cache_dir', s:build_path(expand($HOME), '.cache', 'ctrlp-funky'))
else
  let s:cache_dir = ''
endif

let s:debug = get(g:, 'ctrlp_funky_debug', 0)

let s:custom_hl_list = {}

if s:use_cache
  call s:debug('INFO: cache dir: ' . s:cache_dir)
  if !isdirectory(s:cache_dir)
    try
      call mkdir(s:cache_dir, 'p')
    catch /^Vim\%((\a\+)\)\=:E739/
      echoerr 'ERR: cannot create a directory - ' . s:cache_dir
      finish
    endtry
  endif
endif
call s:debug('INFO: use_cache? ' . (s:use_cache ? 'TRUE' : 'FALSE'))

let &cpo = s:saved_cpo
unlet s:saved_cpo
