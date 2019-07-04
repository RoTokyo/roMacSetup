" Credits
" https://github.com/tmrdev/MacOSVimConfig/blob/master/vimrc-example

set nocompatible

colorscheme desert
set background=light
syntax on

let mapleader=","

set clipboard=unnamed
set wildmenu
set esckeys
set backspace=indent,eol,start
set ttyfast
set gdefault
set encoding=utf-8 nobomb
set binary
set noeol

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&amp;undodir")
	set undodir=~/.vim/undo
endif

set viminfo+=!
set wmh=0
set exrc
set secure
set cursorline
set tabstop=2
set number
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set nolist
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set modeline
set modelines=4
set mouse=a
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showmode
set title
set showcmd
set scrolloff=3

function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

noremap &lt;leader&gt;ss :call StripWhitespace()&lt;CR&gt;
noremap &lt;leader&gt;W :w !sudo tee % &gt; /dev/null&lt;CR&gt;

if has("autocmd")
	filetype on
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

map &lt;C-J&gt; &lt;C-W&gt;j&lt;C-W&gt;_ 
map &lt;C-K&gt; &lt;C-W&gt;k&lt;C-W&gt;_ 
