set hidden
set number cursorline
set cindent copyindent
set linebreak breakindent
set expandtab tabstop=4 shiftwidth=4
set undofile undodir=/var/tmp/nvim
set wildignorecase
set inccommand=split
set ignorecase
set smartcase
set mouse=nv
set timeoutlen=250
set path=.,,**
set gdefault

set termguicolors
colorscheme nord
if exists('$TMUX')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

aug vimrc
	au!
	au BufWritePost $MYVIMRC source $MYVIMRC
	au FileType help nnoremap <silent> <expr> <buffer> q winnr('$') == 1 ? ':bd<cr>' : ':q<cr>'
	au BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
aug END

nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>
nnoremap <c-a> <C-^>
nnoremap <c-x> :bp<Bar>bd! #<CR>

nnoremap <space> :
nnoremap <space>v :e $MYVIMRC<cr>
nnoremap <space>q :conf qa!<cr>
nnoremap <space>w :w<cr>
nnoremap <space>ws :w<cr>
nnoremap <space>wd :w\|bd<cr>
nnoremap <space>wa :wqa<cr>
nnoremap <space>wq :wq!<cr>
nnoremap <space>wn :wn<cr>
nnoremap <space><tab> :ls h<cr>:b<space>
nnoremap <space>f :find<space>
nnoremap <space>s :%s/

nnoremap <up> <c-u>zz
nnoremap <down> <c-d>zz

noremap J }
noremap K {
nnoremap <M-h> K
nnoremap U <C-r>
nnoremap q ``
nnoremap Q `.zz
nnoremap gQ <Nop>
nnoremap s /
nnoremap S ?
nnoremap <c-c> yy
xnoremap <c-c> y
noremap <M-e> g_
noremap L g_

"inoremap <silent> <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

fun! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<c-p>"
  elseif "forward" == a:direction
    return "\<c-n>"
  else
    return "\<c-x>\<c-k>"
  endif
endf

inoremap <expr> <silent> <tab> InsertTabWrapper("forward")
inoremap <expr> <silent> <s-tab> InsertTabWrapper("backward")

nnoremap <silent> <space>l :nohls<cr><c-l>
