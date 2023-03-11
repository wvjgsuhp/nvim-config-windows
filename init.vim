let $VIM_PATH = expand('<sfile>:p:h')
let g:python3_host_prog = $VIM_PATH . '\env\Scripts\python.exe'
let &shell = '"C:/Program Files/Git/bin/bash.exe"'
let &shellcmdflag = '-c'
set shellxquote=(
set shellslash

function! s:source_file(path, ...)
	" Source user configuration files with set/global sensitivity
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve($VIM_PATH . '\' . a:path)
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let tempfile = tempname()
	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction

call s:source_file('config\init.vim')
call s:source_file('config\general.vim')
call s:source_file('config\mappings.vim')
call s:source_file('config\tabline.vim')

colorscheme pencil
set background=light

set secure
