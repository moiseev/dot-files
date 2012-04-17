set nocompatible

if has('unix')
    language messages C
else
    language messages en
endif

"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set nobackup
set noswapfile
set ignorecase
set scroll=1
set shiftwidth=4
set tabstop=4
set expandtab
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=-1
set iskeyword=@,48-57,_,192,255
imap <C-\> <C-^>
cmap <C-\> <C-^>
set encoding=utf-8
set hidden
set showmatch
set smartcase
set ch=2		" Make command line two lines high
set mousehide	" Hide the mouse when typing text
set mouse=n     " mouse positioning is only allowed in normal mode
set guioptions-=T
set guioptions-=m	

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set incsearch
set bs=indent,eol,start

if has('unix')
    set guifont=Monaco:h12
    set shell=/bin/zsh

    let s:uname = system("echo -n \"$(uname)\"")
    if !v:shell_error && s:uname == "Linux"
        colo zenburn
    else
        colo vividchalk
    endif
elseif has('win32')
    set guifont=consolas:h12:cRUSSIAN
    "set guifont=Monaco:h10
    "set guifont=Monofur:h14
    set shell=powershell
    set shellslash
    colo vivdchalk
endif

" Only do this for Vim version 5.0 and later.
if version >= 500
  let c_comment_strings=1

  if !exists("syntax_on")
    syntax on
  endif

  set hlsearch

  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95
  highlight CursorLine guibg=#ffffe0
  highlight CursorColumn guibg=#ffffe0
  
  set cursorline
endif

filetype on
filetype plugin on
filetype indent on

let g:tex_flavor='latex'

let mapleader=","
nnoremap <Leader>fs :silent !start fsi<CR>
nnoremap <Leader>gh :silent !start ghci<CR>

nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR> 

nnoremap <CR> o<ESC>
nnoremap <S-CR> O<ESC>j
nnoremap <silent> <TAB><TAB> :set invwrap<CR>

nnoremap ; :
nnoremap <silent> <Leader>ln :set invnu<CR>
nnoremap <silent> <Leader>cd :cd %:h<CR>
nnoremap <silent> <Leader>rm :%s/\r//g<CR>:g/^$/d<CR>
nnoremap <silent> <Leader>\ :s/\\/\\\\/g<CR>

nmap <silent> <S-Tab> :bnext<CR>
"nmap <C-F4> :bd<CR>
nmap <silent> <Leader>w :bd<CR>

" Encloses text under cursor/selection/whatever with specified brackets
"   o -- open bracket
"   c -- closing bracket
"   delcmd -- command for the deletion
fun! EncloseWord(o, c)
    exe "normal mdlbdei" . a:o . "\<Esc>pa" . a:c . "\<Esc>`dl"
endfun

nnoremap <silent> <Leader>( :call EncloseWord('(', ')')<CR>
nnoremap <silent> <Leader>9 :call EncloseWord('(', ')')<CR>
nnoremap <silent> <Leader>< :call EncloseWord('<', '>')<CR>
nnoremap <silent> <Leader>{ :call EncloseWord('{', '}')<CR>
nnoremap <silent> <Leader>[ :call EncloseWord('[', ']')<CR>


map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap j gj
nnoremap k gk

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


nmap <silent> <ESC><ESC> :nohlsearch<CR>

nmap <Leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nmap <Leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap <Leader>N :NERDTreeClose<CR>

let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.obj$']
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
let NERDTreeHighlightCursorLine=1

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

set laststatus=2
" statusline
" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" format markers:
"   %< truncation point
"   %n buffer number
"   %f relative path to file
"   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
"   %r readonly flag [RO]
"   %y filetype [ruby]
"   %= split point for left and right justification
"   %-35. width specification
"   %l current line number
"   %L number of lines in buffer
"   %c current column number
"   %V current virtual column number (-n), if different from %c
"   %P percentage through buffer
"   %) end of width specification
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
