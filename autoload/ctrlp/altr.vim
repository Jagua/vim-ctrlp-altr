

scriptencoding utf-8


if get(g:, 'loaded_ctrlp_altr', 0)
  finish
endif
let g:loaded_ctrlp_altr = 1


let s:save_cpo = &cpo
set cpo&vim


let s:var = {
\ 'init' : 'ctrlp#altr#init(s:crbufnr)',
\ 'accept' : 'ctrlp#acceptfile',
\ 'lname' : 'altr',
\ 'sname' : 'altr',
\ 'type' : 'path',
\ }


if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:var)
else
  let g:ctrlp_ext_vars = [s:var]
endif


let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)


function! ctrlp#altr#init(crbufnr) abort "{{{
  let current_bufname = bufname(a:crbufnr)
  if empty(current_bufname)
    return []
  endif
  let bufname_list = []
  let direction = 'back'
  let bufname = current_bufname
  while !0
    let bufname = altr#_infer_the_missing_path(bufname, direction, altr#_rule_table())
    if type(bufname) != v:t_string
      if direction ==# 'back'
        let direction = 'forward'
        let bufname = current_bufname
        continue
      elseif direction ==# 'forward'
        break
      endif
    elseif bufname ==# current_bufname
      break
    endif
    call add(bufname_list, bufname)
  endwhile
  return bufname_list
endfunction "}}}


function! ctrlp#altr#id() abort "{{{
  return s:id
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
