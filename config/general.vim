let g:python3_host_prog = $HOME . '/.config/nvim/env/bin/python3'

set cmdheight=0
set clipboard+=unnamedplus     " Yank without explicit registration
set ignorecase
set winbar+=%{%v:lua.require'nvim-navic'.get_location()%}
set showtabline=0
set synmaxcol=2048

if has('folding') && has('vim_starting')
	set foldenable
	set foldmethod=indent
	set foldlevel=99
endif

function! Recording()
  let l:recording_register = reg_recording()
  if l:recording_register == ""
    return ""
  else
    return "recording @" .. l:recording_register .. ' '
  endif
endfunction

" Statusline
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_y = '%{Recording()}%{strftime("%H:%M")}'
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
set exrc

" Markdown TOC
let g:vmt_list_item_char = '-'

" fzf
" scoop
" set rtp+=~/scoop/shims/fzf
" choco
" set rtp+=/c/ProgramData/chocolatey/bin/fzf

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
  autocmd BufWritePre *.html Neoformat
  autocmd BufWritePre *.java Neoformat
  autocmd BufWritePre *.js Neoformat
  autocmd BufWritePre *.json Neoformat
  autocmd BufWritePre *.jsx Neoformat
  autocmd BufWritePre *.lua Neoformat
  autocmd BufWritePre *.md Neoformat
  autocmd BufWritePre *.py Neoformat
  autocmd BufWritePre *.rs Neoformat
  autocmd BufWritePre *.sql Neoformat
  autocmd BufWritePre *.ts Neoformat
  autocmd BufWritePre *.tsx Neoformat
  autocmd BufWritePre *.yaml Neoformat
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

augroup user_general_settings
  autocmd!

  " Show sign column only for normal file buffers.
  if exists('&signcolumn')
    autocmd FileType * if empty(&buftype)
          \ | setlocal signcolumn=yes
          \ | endif
  endif

  " Highlight current line only on focused normal buffer windows
  autocmd WinEnter,BufEnter,InsertLeave *
        \ if ! &cursorline && empty(&buftype)
        \ | setlocal cursorline
        \ | endif

  " Hide cursor line when leaving normal non-diff windows
  autocmd WinLeave,BufLeave,InsertEnter *
        \ if &cursorline && ! &diff && empty(&buftype) && ! &pvw && ! pumvisible()
        \ | setlocal nocursorline
        \ | endif

  " Reload vim configuration automatically on-save
  " autocmd BufWritePost $VIM_PATH/{*.vim,*.yaml,vimrc} ++nested
        " \ source $MYVIMRC | redraw

  " Automatically set read-only for files being edited elsewhere
  autocmd SwapExists * ++nested let v:swapchoice = 'o'

  " Update diff comparison once leaving insert mode
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  " Equalize window dimensions when resizing vim window
  autocmd VimResized * wincmd =

  " Force write shada on leaving nvim
  autocmd VimLeave * if has('nvim') | wshada! | endif

  " Check if file changed when its window is focus, more eager than 'autoread'
  autocmd FocusGained * checktime

  " autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

  if has('nvim-0.5')
    " Highlight yank
    try
      autocmd TextYankPost *
            \ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
    endtry

    " Neovim terminal settings
    autocmd TermOpen * setlocal modifiable
  endif

  " Update filetype on save if empty
  autocmd BufWritePost * ++nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " Reload Vim script automatically if setlocal autoread
  autocmd BufWritePost,FileWritePost *.vim ++nested
        \ if &l:autoread > 0 | source <afile> |
        \   echo 'source ' . bufname('%') |
        \ endif

  " When editing a file, always jump to the last known cursor position.
  " Credits: https://github.com/farmergreg/vim-lastplace
  autocmd BufReadPost *
        \ if index(['gitcommit', 'gitrebase', 'svn', 'hgcommit'], &filetype) == -1
        \      && empty(&buftype) && ! &diff && ! &previewwindow
        \      && line("'\"") > 0 && line("'\"") <= line("$")
        \|   if line("w$") == line("$")
        \|     execute "normal! g`\""
        \|   elseif line("$") - line("'\"") > ((line("w$") - line("w0")) / 2) - 1
        \|     execute "normal! g`\"zz"
        \|   else
        \|     execute "normal! \G'\"\<c-e>"
        \|   endif
        \|   if foldclosed('.') != -1
        \|     execute 'normal! zvzz'
        \|   endif
        \| endif
augroup END
