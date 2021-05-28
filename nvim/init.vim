" OPTIONS
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
set notimeout
set path=.,,**
set gdefault
set termguicolors
set bs="indent,eol"

if exists('$TMUX')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

aug vimrc
	au!
	au BufWritePost $MYVIMRC source $MYVIMRC
	au vimrc BufEnter * set formatoptions=jncrql
	au BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	au VimResized * wincmd =
    au FileType netrw setlocal bufhidden=delete
	au FileType qf nnoremap <silent> <buffer> q :close<CR>
	au FileType help nnoremap <silent> <expr> <buffer> q winnr('$') == 1 ? ':bd<cr>' : ':q<cr>'
	au FileType help wincmd o
    " au BufEnter * if &ft ==# 'help' | wincmd o | endif
aug END

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" PLUGINS
call plug#begin(stdpath('data') . '/plugged')

Plug 'sheerun/vim-polyglot'

" packadd nvim-treesitter

" lua << EOF
"   require'nvim-treesitter.configs'.setup {
"     ensure_installed = {"c", "bash", "python"},
"     highlight = {
"       enable = true,
"       use_languagetree = false,
"     },
"     indent = {
"       enable = false
"     },
"     incremental_selection = {
"       enable = true,
"       keymaps = {
"         init_selection = "<m-w>",
"         node_incremental = "<m-w>",
"         node_decremental = "<m-W>",
"       },
"     },
"   }
" EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

let g:fzf_layout = { 'window': { 'width': 0.618, 'height': 0.4 } }

" let g:fzf_layout = { 'down': '~25%' }
" au! FileType fzf
" au  FileType fzf set laststatus=0 noshowmode noruler
"             \| au BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_nvim_statusline = 0
let g:fzf_buffers_jump = 1

let g:fzf_colors =
          \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Statement'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'Normal'],
            \ 'hl+':     ['fg', 'SpecialComment'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

command! -nargs=* -complete=dir Directories call fzf#run(fzf#wrap(
            \ {'source': 'fd . -H -td ~',
            \  'sink': 'cd'}))

imap <C-X><C-F> <plug>(fzf-complete-path)
imap <C-X><C-L> <plug>(fzf-complete-line)

Plug 'junegunn/vim-slash'
noremap <plug>(slash-after) zz

Plug 'wellle/targets.vim'
aug targets
au User targets#mappings#user call targets#mappings#extend({
    \ 'b': { 'pair': [{'o':'(', 'c':')'}] },
    \ 'r': { 'pair': [{'o':'[', 'c':']'}] },
    \ 's': { 'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}] },
    \ 'o': { 'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}] },
    \ 'd': { 'separator': [{'d':','}, {'d':'.'}, {'d':';'}, {'d':':'}, {'d':'+'}, {'d':'-'},
    \                      {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
    \                      {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'}] },
    \ })
aug END

Plug 'machakann/vim-sandwich/'
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1

Plug 'tpope/vim-commentary'
Plug 'dkarter/bullets.vim'

Plug 'andymass/vim-matchup'

" Plug 'jiangmiao/auto-pairs'
Plug 'cohama/lexima.vim'

Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'

" Plug 'RRethy/vim-illuminate'
Plug 'dstein64/nvim-scrollview'
let g:scrollview_winblend = 0

" COLORS
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'romgrk/doom-one.vim'
Plug 'jdkanani/vim-material-theme'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ajmwagar/vim-deus'
Plug 'Rigellute/rigel'
Plug 'yuttie/inkstained-vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ayu-theme/ayu-vim'
let ayucolor = 'mirage'
Plug 'sainnhe/sonokai'
let g:sonokai_style = 'atlantis'
let g:sonokai_disable_italic_comment = 1

call plug#end()

" THEME
set bg=dark
let g:theme = readfile($HOME . "/colorfile")[0]
execute 'colorscheme ' . g:theme

let g:colors = [
            \ "nord",
            \ "onedark",
            \ "doom-one",
            \ "material-theme",
            \ "palenight",
            \ "deus",
            \ "rigel",
            \ "inkstained",
            \ "quantum",
            \ "hybrid_material",
            \ "ayu",
            \ "sonokai",
            \ ]

fun! SetColors(colorscheme)
    let g:theme = a:colorscheme
    call writefile([g:theme], $HOME . "/colorfile")
    execute 'colorscheme ' . g:theme
    echo g:theme
endf

fun! CRotate(direction)
    let idx = index(g:colors, g:theme)
    if a:direction == 0
        let idx = (idx + 1) % len(g:colors)
    else
        let idx = (idx - 1 % len(g:colors) + len(g:colors)) % len(g:colors)
    endif
    call SetColors(g:colors[idx])
endf

nnoremap <silent> <F3> :call CRotate(0)<CR>
nnoremap <silent> <F4> :call CRotate(1)<CR>

" KEYBINDS
noremap  <M-q> <Esc>
inoremap <M-q> <Esc>
cnoremap <M-q> <C-C>
xnoremap q o<Esc>

noremap J }
noremap K {
noremap H ^
noremap L g_
noremap <M-e> g_

nnoremap <Up> <c-u>zz
nnoremap <Down> <c-d>zz
nnoremap <M-j> 10gjzz
nnoremap <M-k> 10gkzz
nmap gj ]]
nmap gk [[

" Jumping
nnoremap <CR> <C-]>zz
nnoremap ¨ <C-]>zz
nnoremap <m-i> <c-i>
nnoremap <m-o> <c-o>

nnoremap U <C-r>
nnoremap s /
nnoremap S :BLines<CR>
nnoremap q ``
nnoremap Q `.zz
nnoremap <C-c> yy
xnoremap <C-c> y
nnoremap <M-h> K
inoremap <M-r> <C-r>
inoremap <M-r><M-r> <C-r>"
map gb %
nnoremap gr :%s/\<<c-r><c-w>\>/

" Buffers
nnoremap <silent> <C-n> :bn<cr>
nnoremap <silent> <C-p> :bp<cr>
nnoremap <silent> <C-a> <C-^>
nnoremap <silent> <C-x> :bp<Bar>bd! #<CR>

" Leader/files
nnoremap <space> :
nnoremap <space><space> <Esc>
nnoremap <space>v :e $MYVIMRC<cr>
nnoremap <space>q :conf qa!<cr>
nnoremap <space>s :w<cr>
nnoremap <space>ww :w<cr>
nnoremap <space>wd :w\|bp\|bd! #<cr>
nnoremap <space>wa :wqa<cr>
nnoremap <space>wq :wq!<cr>
nnoremap <space>wn :wn<cr>
" nnoremap <expr> <space><tab> len(getbufinfo({'buflisted':1})) == 2 ? ":bn\<cr>" : ":ls h\<cr>:b\<space>"
nnoremap <space>f :find<space>
" nnoremap <space>e :e<space>
nnoremap <silent> <space>l :nohls<cr><c-l>
nnoremap <silent> <space><bs> :e!<CR>zz
nnoremap <space>d :e!<CR>zz
" nnoremap <space>r :e!<CR>zz
" nnoremap <space>s :%s/
" xnoremap <space>s :s/
" nnoremap <space>en :enew<cr>
" nnoremap <space>rg :reg<CR>

nnoremap <silent> <expr> <space><tab> len(getbufinfo({'buflisted':1})) == 2 ? ":bn\<CR>" : ":Buffers<CR>"
nnoremap <silent> <space>e :Files<CR>
nnoremap <silent> <space>g :GFiles<CR>
nnoremap <silent> <space>r :History<CR>
nnoremap <silent> <m-x> :Commands<CR>
nnoremap <silent> <space>* :Grep "\b<cword>\b"<CR>
nnoremap <space>/ :Ag<Space>
nnoremap <silent> <C-G> :Ag<CR>
nnoremap <silent> <space>a :Ag<CR>
nnoremap <silent> <space>' :Marks<CR>
nnoremap <silent> <space>j :Vista finder<CR>
nnoremap <silent> <space>h  :Helptags<CR>

nnoremap <silent> cd :Directories<CR>

" Grepping
" if executable('ag') | set grepprg=ag\ --vimgrep\ --silent | endif
" command! -nargs=? -complete=file_in_path Grep silent grep! <args>
" nmap <silent> <space>o <Plug>(qf_qf_toggle)

" Run
command! -nargs=* R up|!%:p <args>
nnoremap <F1> :R<cr>
nnoremap <F12> :R<cr>

" Completion
inoremap <M-n> <C-N>
inoremap <M-p> <C-P>
cnoremap <M-n> <C-N>
cnoremap <M-p> <C-P>
imap <M-l> <C-X><C-L>
imap <M-x> <C-X><C-F>

set omnifunc=syntaxcomplete#Complete
inoremap <expr> <M-u> pumvisible() ? "<C-e>" : "<Esc>u"
inoremap <expr> <M-o> pumvisible() ? "<C-o>" : "<C-x><C-o>"

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

" Comments
nmap <M-c> gcc
xmap <M-c> gc
xmap <M-C> :t-1<CR>gvgc
nmap <M-C> :t-1<CR>gccj

" Indenting
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv
nmap < <<
nmap > >>

" Sandwich
call operator#sandwich#set('delete', 'all', 'highlight', 0)

nmap <M-r> <Plug>(operator-sandwich-add)
xmap <M-r> <Plug>(operator-sandwich-add)
xmap <M-s> <Plug>(operator-sandwich-add)
nmap ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap dss <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap css <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

nmap <M-s> <M-r>iw
nmap <M-S> <m-r>iW
nmap <M-R> <M-r>g_
onoremap <silent> <sid>line :normal! ^vg_<CR>
nmap <M-r><M-r> <M-r><sid>line

" Shortcuts
nnoremap vv viw
nnoremap VV viW
nnoremap dn dgn
nnoremap cn cgn
nmap <M-n> *cgn
nmap vs vis
nmap co cio
nmap do dao
nmap vo vio
nmap go yao
nmap vd vid
" nmap cd cid

nnoremap dp yyp

noremap <M-f> <C-Right>
noremap <M-b> <C-Left>

nnoremap <m-d> dW
nnoremap <m-D> daW

nnoremap <M-w> viw
nnoremap <M-W> viW
xnoremap <M-w> y
xnoremap <M-W> y

set scrolloff=999

