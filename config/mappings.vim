" Mapping
let mapleader = ' '

" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>
command! ToggleTerminal call interface#toggleTerminal()
nnoremap <Leader>` :ToggleTerminal<cr>

" Paste
nnoremap <Leader>piw viwpyiw
nnoremap <Leader>pa ggVGp

" Go to tab by number
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 <cmd>tablast<cr>

" Jump to the beginning/end of a line
noremap <Leader>h ^
noremap <Leader>l $

" Open terminal
noremap <Leader>zz <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<cr><bar><cmd>wincmd j<cr><bar><cmd>terminal<cr>13<c-w>_i
noremap <Leader>zl <cmd>vsplit<cr><bar><cmd>wincmd l<cr><bar><cmd>terminal<cr>i

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous buffer
noremap <Leader>bb <c-^>

" Yank
nnoremap <Leader>yfn <cmd>let @+=expand("%")<CR><cmd>echo 'Yanked filename'<CR>
nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR><cmd>echo 'Yanked relative path'<CR>
nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR><cmd>echo 'Yanked absolute path'<CR>
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
nnoremap <Leader>gdh <cmd>diffget //2<cr>
nnoremap <Leader>gdl <cmd>diffget //3<cr>
nnoremap <Leader>gpn 6kyyGpi

" Find
nnoremap <Leader>fp /<C-r>0<cr>zz
nnoremap <Leader>fiw yiw/<C-r>0<cr>zz
nnoremap <Leader>fn :Navbuddy<cr>

" Center focused line
let line_moved_commands = ['u', 'e', '<c-r>', 'n', 'N', 'G', 'w', 'b', '``']
for cmd in line_moved_commands
  execute 'nmap <silent> '.cmd.' '.cmd.'zz'
  execute 'vmap <silent> '.cmd.' '.cmd.'zz'
endfor

vmap <silent> j jzz
vmap <silent> k kzz
cmap <expr> <cr> getcmdtype() =~ '^[/?]$' ? '<cr>zz' : '<cr>'

" Fast saving
nnoremap <Leader>w <cmd>write<CR>:<esc>
nnoremap <C-s> <cmd>write<CR>:<esc>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Buffer
nnoremap <silent> <F12> <cmd>bn<CR>
nnoremap <silent> <F24> <cmd>bp<CR>
nnoremap <silent> <A-}> <cmd>bn<CR>
nnoremap <silent> <A-{> <cmd>bp<CR>

" Edit file
nnoremap <Leader>ze :e ~/.zshrc<cr>

if dein#tap('nvim-tree.lua')
	nnoremap <Leader>e :NvimTreeToggle .<cr>:NvimTreeResize 34<cr>
	nnoremap <Leader>fe :NvimTreeFindFile<cr>:NvimTreeResize 34<cr>:NvimTreeFocus<cr>
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
	noremap <Leader>fb <cmd>HopChar2<cr>
endif

if dein#tap('omnisharp-vim')
  autocmd FileType cs nmap <silent> <buffer> gD <Plug>(omnisharp_find_implementations)
endif

if dein#tap('sideways.vim')
  noremap <Leader>sh <cmd>SidewaysLeft<cr>
  noremap <Leader>sl <cmd>SidewaysRight<cr>
  nmap <leader>si <Plug>SidewaysArgumentInsertBefore
  nmap <leader>sa <Plug>SidewaysArgumentAppendAfter
  nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
  nmap <leader>sA <Plug>SidewaysArgumentAppendLast
endif

if dein#tap('symbols-outline.nvim')
  nmap <leader>fs :SymbolsOutline<cr>
endif

if dein#tap('fine-cmdline.nvim')
  nnoremap : <cmd>FineCmdline<CR>
  xnoremap : <cmd>FineCmdline '<,'><CR>
endif

if dein#tap('telescope.nvim')
  nnoremap <Leader>ff <cmd>Telescope find_files<CR>
  nnoremap <Leader>fg <cmd>Telescope live_grep<CR>
  nnoremap <Leader>fz <cmd>Telescope grep_string<CR>
  nnoremap <Leader>cbf <cmd>Telescope current_buffer_fuzzy_find<CR>
endif
