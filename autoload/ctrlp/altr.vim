

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
  let bufname = bufname(a:crbufnr)
  let pwd = fnamemodify(bufname, ':p')
  let cwd = pwd
  let files = []
  while !0
    call add(files, pwd)
    let path = altr#_infer_the_missing_path(pwd, 'forward', altr#_rule_table())
    if type(path) == type('')
      let pwd = path
      if pwd == cwd
        break
      endif
    else
      break
    endif
    unlet path
  endwhile
  return files
endfunction "}}}


function! ctrlp#altr#id() abort "{{{
  return s:id
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
