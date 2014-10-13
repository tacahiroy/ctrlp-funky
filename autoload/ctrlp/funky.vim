" File: autoload/ctrlp/funky.vim
" Description: a simple ctrlp.vim extension provides jumping to a function
" Author: Takahiro Yoshihara <tacahiroy@gmail.com>
" License: The MIT License
" Copyright (c) 2012-2014 Takahiro Yoshihara

" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:

" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.

" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

if get(g:, 'loaded_ctrlp_funky', 0)
  finish
endif
let g:loaded_ctrlp_funky = 1

let s:saved_cpo = &cpo
set cpo&vim

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

function! s:filetype(bufnr)
  return getbufvar(a:bufnr, '&l:filetype')
endfunction

function! s:has_filter(ft)
  let func = 'autoload/ctrlp/funky/ft/' . a:ft . '.vim'
  return !empty(globpath(&runtimepath, func))
endfunction

function! s:has_post_extract_hook(ft)
  return exists('*ctrlp#funky#ft#' . a:ft . '#post_extract_hook')
endfunction

function! s:filters_by_filetype(ft, bufnr)
  let filters = []

  if s:filters.is_cached(a:ft)
    return s:filters.load(a:ft)
  else
    " NOTE: new API since v0.6.0
    let filters = ctrlp#funky#ft#{a:ft}#filters()
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
        call s:fu.debug('Extract: ' . reltimestr(reltime(st)))
        if s:has_post_extract_hook(ft)
          call ctrlp#funky#ft#{ft}#post_extract_hook(candidates)
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
    if s:use_cache && s:fu.is_real_file(a:bufnr) && s:cache.is_maybe_unchanged(a:bufnr)
      call s:fu.debug('CACHE FILE:' . s:cache.filename(s:fu.fname(a:bufnr)))
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

    if s:use_cache && s:fu.is_real_file(a:bufnr)
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

  " should be current window = former window
  let bufnr = matchstr(a:str, '\d\+\ze:\d\+$')
  let lnum = matchstr(a:str, '\d\+$')
  call cursor(lnum, 1)

  call s:after_jump()

  if !s:sort_by_mru | return | endif

  call s:mru.prioritise(bufnr, s:definition(a:str))
endfunction

function!ctrlp#funky#exit()
  if !empty(s:errmsg) | call s:error(s:errmsg) | endif
endfunction

" Allow it to be called later
function! ctrlp#funky#id()
  return s:id
endfunction

function! ctrlp#funky#highlight(pat, from_group, to_group)
  let s:custom_hl_list[a:from_group] = { 'pat': a:pat, 'to_group': a:to_group }
endfunction

function! ctrlp#funky#clear_cache(path)
  call s:cache.clear(a:path)
endfunction

function! ctrlp#funky#clear_cache_all()
  call s:cache.clear_all()
endfunction

""
" Configuration
"
let s:errmsg = ''
let s:custom_hl_list = {}

let g:ctrlp#funky#is_debug = get(g:, 'ctrlp_funky_debug', 0)
let s:report_filter_error = get(g:, 'ctrlp_funky_report_filter_error', 0)
let s:sort_by_mru = get(g:, 'ctrlp_funky_sort_by_mru', 0)
" after jump action
let s:after_jump = get(g:, 'ctrlp_funky_after_jump', 'zxzz')
" 1: set the same filetype as source buffer
let s:syntax_highlight = get(g:, 'ctrlp_funky_syntax_highlight', 0)

let s:matchtype = get(g:, 'ctrlp_funky_matchtype', 'line')
if index(['line', 'path', 'tabs', 'tabe'], s:matchtype) < 0
  echoerr 'WRN: value "' . s:matchtype . '" not allowed for g:ctrlp_funky_matchtype.'
  let s:matchtype = 'line'
endif

let s:fu = ctrlp#funky#utils#new()

" cache
let s:use_cache = get(g:, 'ctrlp_funky_use_cache', 0)
if s:use_cache
  let cache_dir = get(g:, 'ctrlp_funky_cache_dir', s:fu.build_path(expand($HOME), '.cache', 'ctrlp-funky'))
  let s:cache = ctrlp#funky#cache#new(cache_dir)
endif

if s:use_cache
  call s:fu.debug('INFO: cache dir: ' . s:cache.dir)
  if !isdirectory(s:cache.dir)
    try
      call mkdir(s:cache.dir, 'p')
    catch /^Vim\%((\a\+)\)\=:E739/
      echoerr 'ERR: cannot create a directory - ' . s:cache.dir
      finish
    endtry
  endif
endif
call s:fu.debug('INFO: use_cache? ' . (s:use_cache ? 'TRUE' : 'FALSE'))

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
  \ 'type':   s:matchtype,
  \ 'exit':  'ctrlp#funky#exit()',
  \ 'nolim':  get(g:, 'ctrlp_funky_nolim', 0),
  \ 'sort':   0
  \ })

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

let &cpo = s:saved_cpo
unlet s:saved_cpo
