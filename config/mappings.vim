" Mapping
let mapleader = ' '

" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>

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
noremap <Leader>hh ^
noremap <Leader>l $

" Open terminal
noremap <Leader>z <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<cr><bar><cmd>wincmd j<cr><bar><cmd>terminal<cr>13<c-w>_i
noremap <Leader>zl <cmd>vsplit<cr><bar><cmd>terminal<cr>i

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous buffer
noremap <Leader>bb <c-^><cr>

" Fix incorrect highlight
" noremap <Leader>ffs <cmd>colorscheme github<cr>

" Yank
nnoremap <Leader>yfn <cmd>let @+=expand("%")<CR><cmd>echo 'Yanked filename'<CR>
nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR><cmd>echo 'Yanked relative path'<CR>
nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR><cmd>echo 'Yanked absolute path'<CR>
nnoremap <Leader>yaa ggyG''

" Delete
nnoremap <Leader>dc j<cmd>foldclose<cr>kd1j

" Delete current file
nnoremap <Leader>rm <cmd>call delete(expand('%'))<bar>bd!<cr>

" Close current buffer
nnoremap <Leader>bd <cmd>b#<bar>bd#<CR>

" Trouble
nnoremap <Leader>xd <cmd>Trouble document_diagnostics<cr>
nnoremap <Leader>xw <cmd>Trouble workspace_diagnostics<cr>

" Git
nnoremap <Leader>gdh <cmd>diffget //2<cr>
nnoremap <Leader>gdl <cmd>diffget //3<cr>
nnoremap <Leader>gpn 6kyyGpi

" Search
nnoremap <Leader>agp :Ag <C-r>0<cr>
nnoremap <Leader>agiw yiw:Ag <C-r>0<cr>

" Find
nnoremap <Leader>fp /<C-r>0<cr>
nnoremap <Leader>fiw yiw/<C-r>0<cr>

" Fast saving
nnoremap <silent> <Leader>w <cmd>write<CR><CR>

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

if dein#tap('nvim-tree.lua')
	nnoremap <Leader>e <cmd>NvimTreeToggle .<cr>
endif

if dein#tap('splitjoin.vim')
	nmap sj <cmd>SplitjoinJoin<CR>
	nmap ss <cmd>SplitjoinSplit<CR>
endif

if dein#tap('accelerated-jk')
	nmap <silent> j <Plug>(accelerated_jk_gj)
	nmap <silent> k <Plug>(accelerated_jk_gk)
endif
