" Mapping
let mapleader = ' '

nnoremap <Leader>cf" f"ci"

" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>
command! ToggleTerminal call interface#toggleTerminal()
nnoremap <Leader>` <cmd>ToggleTerminal<cr>

" Paste
nmap <Leader>piw viwp
nmap <Leader>pa ggVGp

" Paste in visual-mode without pushing to register
xnoremap p :call <SID>visual_paste('p')<CR>
xnoremap P :call <SID>visual_paste('P')<CR>

" Jump to the beginning/end of a line
noremap <Leader>h ^
nnoremap <Leader>l $
onoremap <Leader>l $
xnoremap <Leader>l $h

" Open terminal
noremap <Leader>zz <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<bar>terminal<cr>13<c-w>_i
nmap <Leader>zl <cmd>vsplit<cr> zz

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous buffer
noremap <Leader>bb <c-^>

" Toggle fold
nmap <CR> za
nmap <Leader><Leader> za

" Yank
if dein#tap('nvim-notify')
  nnoremap <Leader>yfn <cmd>let @+=expand("%:t")<CR>
    \ :lua vim.notify('Yanked filename: <c-r>+', 'info')<CR>
  nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR>
    \ :lua vim.notify('Yanked relative path: <c-r>+', 'info')<CR>
  nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR>
    \ :lua vim.notify('Yanked absolute path: <c-r>+', 'info')<CR>
else
  nnoremap <Leader>yfn <cmd>let @+=expand("%:t")<CR>
    \ <cmd>echo 'Yanked filename: <c-r>+'<CR>
  nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR>
    \ <cmd>echo 'Yanked relative path: <c-r>+'<CR>
  nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR>
    \ <cmd>echo 'Yanked absolute path: <c-r>+'<CR>
endif
nnoremap <Leader>yaa ggyG''
nnoremap <Leader>ypG VGyGp

" Delete
nnoremap <Leader>dc j<cmd>foldclose<cr>kd1j

" Delete current file
nnoremap <Leader>rm <cmd>call delete(expand('%'))<bar>b#<bar>bd#<CR>

" Close current buffer
nnoremap <Leader>bd <cmd>b#<bar>bd#<CR>

" Trouble
nnoremap <Leader>xd <cmd>Trouble document_diagnostics<cr>
nnoremap <Leader>xw <cmd>Trouble workspace_diagnostics<cr>

" Git
nnoremap <Leader>gds <cmd>Gvdiffsplit!<cr>
nnoremap <Leader>gdh <cmd>diffget //2<cr>
nnoremap <Leader>gdl <cmd>diffget //3<cr>
nnoremap <Leader>gpn 6kyyGpi

" Find
nnoremap <Leader>fp /<C-r>0<cr>zz
nnoremap <Leader>fiw yiw/<C-r>0<cr>Nzz
nnoremap <Leader>fn <cmd>Navbuddy<cr>

" Use backspace key for matching parens
nnoremap <BS> %
xnoremap <BS> %

" Center focused line
let line_moved_commands = ['u', 'e', '<c-r>', 'n', 'N', 'G', 'w', 'b', '``', 'p', 'za']
for cmd in line_moved_commands
  execute 'nmap <silent> '.cmd.' '.cmd.'zz'
  execute 'vmap <silent> '.cmd.' '.cmd.'zz'
endfor

vmap <silent> j jzz
vmap <silent> k kzz
cmap <expr> <cr> getcmdtype() =~ '^[/?]$' ? '<cr>zz' : '<cr>'

" Fast saving
nnoremap <Leader>w <cmd>silent write<CR>
nnoremap <C-s> <cmd>silent write<CR>
xnoremap <C-s> <cmd>silent write<CR>
cnoremap <C-s> <cmd>silent write<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> <cmd>wincmd k<CR>
nmap <silent> <c-j> <cmd>wincmd j<CR>
nmap <silent> <c-h> <cmd>wincmd h<CR>
nmap <silent> <c-l> <cmd>wincmd l<CR>

" Buffer
nnoremap <silent> <F12> <cmd>bn<CR>
nnoremap <silent> <F24> <cmd>bp<CR>
nnoremap <silent> <A-}> <cmd>bn<CR>
nnoremap <silent> <A-{> <cmd>bp<CR>

" Edit file
nnoremap <Leader>ze :e ~/.zshrc<cr>

" Print messages to buffer
nnoremap <Leader>mb <cmd>put =execute('messages')<cr>
nmap <Leader>ml <cmd>vs<bar>execute 'edit'
  \ strftime('vim-messages-%Y-%m-%d.%H-%M-%S.log')<cr> mb
nmap <Leader>mj <cmd>sp<bar>execute 'edit'
  \ strftime('vim-messages-%Y-%m-%d.%H-%M-%S.log')<cr> mb

if dein#tap('nvim-tree.lua')
  nnoremap <Leader>e <cmd>NvimTreeToggle .<bar>NvimTreeResize 34<cr>
  nnoremap <Leader>fe <cmd>NvimTreeFindFile<bar>NvimTreeResize 34<bar>
    \ NvimTreeFocus<cr>
endif

if dein#tap('splitjoin.vim')
  nmap sj <cmd>SplitjoinJoin<CR>
  nmap ss <cmd>SplitjoinSplit<CR>
endif

if dein#tap('accelerated-jk')
  nmap <silent> j <Plug>(accelerated_jk_gj)zz
  nmap <silent> k <Plug>(accelerated_jk_gk)zz
endif

if dein#tap('vim-choosewin')
  nmap -         <Plug>(choosewin)
  nmap <Leader>- <cmd>ChooseWinSwapStay<CR>
endif

if dein#tap('hop.nvim')
  noremap <Leader>fw <cmd>HopWord<cr>
  noremap <Leader>fa <cmd>HopAnywhere<cr>
  noremap <Leader>fl <cmd>HopLine<cr>
  noremap <Leader>fc <cmd>HopChar1<cr>
  " noremap <Leader>fb <cmd>HopChar2<cr>
endif

if dein#tap('omnisharp-vim')
  autocmd FileType cs nmap <silent> <buffer> gD <Plug>(omnisharp_find_implementations)
endif

if dein#tap('sideways.vim')
  noremap <Leader>ah <cmd>SidewaysLeft<cr>
  noremap <Leader>al <cmd>SidewaysRight<cr>
  nmap <leader>ai <Plug>SidewaysArgumentInsertBefore
  nmap <leader>aa <Plug>SidewaysArgumentAppendAfter
  nmap <leader>aI <Plug>SidewaysArgumentInsertFirst
  nmap <leader>aA <Plug>SidewaysArgumentAppendLast
endif

if dein#tap('symbols-outline.nvim')
  nmap <leader>fs <cmd>SymbolsOutline<cr>
endif

if dein#tap('fine-cmdline.nvim')
  nnoremap : <cmd>FineCmdline<CR>
  xnoremap : <cmd>FineCmdline '<,'><CR>
endif

if dein#tap('telescope.nvim')
  nnoremap <Leader>ff <cmd>Telescope find_files<CR>
  nnoremap <Leader>fg <cmd>Telescope live_grep<CR>
  nnoremap <Leader>fz <cmd>Telescope grep_string<CR>
  nnoremap <Leader>fb <cmd>Telescope current_buffer_fuzzy_find<CR>
endif

if dein#tap('fsread.nvim')
  nnoremap <Leader>br <cmd>FSToggle<CR>
endif
