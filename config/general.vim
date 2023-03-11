let g:python3_host_prog = $HOME . '/.config/nvim/env/bin/python3'

set cmdheight=0
set clipboard+=unnamedplus     " Yank without explicit registration
set ignorecase

" Statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline_section_z = airline#section#create([g:airline_symbols.colnr, '%v'])
let g:airline_detect_spell = 0
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }
" Mitigate error with git bash https://github.com/vim-airline/vim-airline/issues/2479
let g:airline#extensions#branch#vcs_checks = []

let mapleader = ' '

set clipboard+=unnamedplus     " Yank without explicit registration
set showcmd
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set tabstop=2 shiftwidth=2 expandtab

" Markdown TOC
let g:vmt_list_item_char = '-'

" fzf x ag
command! -bang -nargs=* Ag call fzf#vim#grep('ag --path-to-ignore ~/.ignore --column --numbers --smart-case --noheading --color ' . shellescape(<q-args>), 1)
set rtp+=~/scoop/shims/fzf

" Formatting
let g:neoformat_sql_sqlformat = {
	    \ 'exe': 'sqlformat',
	    \ 'args': ['--keywords=upper']
	    \ }

let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'args': ['--max-line-length=80', '--experimental'],
            \ }

augroup formatting
  autocmd!
	autocmd BufWritePre *.js Neoformat
	autocmd BufWritePre *.jsx Neoformat
	autocmd BufWritePre *.ts Neoformat
	autocmd BufWritePre *.tsx Neoformat
	autocmd BufWritePre *.json Neoformat
	autocmd BufWritePre *.py Neoformat
	autocmd BufWritePre *.md Neoformat
	autocmd BufWritePre *.sql Neoformat
	autocmd BufWritePre *.rs Neoformat
augroup END

" Save sessions
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()
