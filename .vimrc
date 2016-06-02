" vim:set ts=2 sts=2 sw=2 expandtab:
" This is kainlite vimrc

" Load bundles
if filereadable(expand("~/.vimrc.bundles"))
  call plug#begin('~/.vim/plugged')
  source ~/.vimrc.bundles
  call plug#end()
endif

" Set encoding if available
if has('multi_byte')
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Set spellcheck
if has('spell')
  set spelllang=en_us
  nnoremap _s :set spell!<CR>
endif

if !exists('g:fugitive_git_executable')
  let g:fugitive_git_executable='LC_ALL=en_US git'
endif

if exists('+writebackup')
  set nobackup
  set writebackup
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set number
set nobomb

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set numberwidth=2
set showtabline=2
set winwidth=79
set ttimeoutlen=50

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" This makes RVM work inside Vim. I have no idea why.
set shell=zsh
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=/var/tmp,/tmp
set directory=/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
noremap <leader>s :update<CR>
let g:syntastic_check_on_open=0
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType rb,ruby,haml,eruby,yaml,html,tmpl,javascript,sass,cucumber,js,jsx,ex,eex set ai sw=2 sts=2 et
  autocmd FileType c,cpp set ai tabstop=8 softtabstop=8 shiftwidth=8 expandtab
  autocmd FileType python set sw=4 sts=4 et
  autocmd Filetype prolog set syntax=prolog

  autocmd BufNewFile,BufRead *.ejs set filetype=html
  autocmd BufNewFile,BufRead *.jsx set filetype=html
  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
  
  autocmd BufNewFile,BufRead *.prawn setf ruby
  
  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " For everything else use this default to prevent the tab _casqueada_
  autocmd Filetype * set sw=2 sts=2  ts=2 expandtab
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default move with display lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction

nnoremap <leader><leader> <c-^>
nnoremap <leader>. :nohlsearch<cr>
nnoremap _ts :silent !tmux set status<CR>

" for linux and windows users (using the control key)
map <c-a> gT
map <c-s> gt
map <c-1> 1gt
map <c-2> 2gt
map <c-3> 3gt
map <c-4> 4gt
map <c-5> 5gt
map <c-6> 6gt
map <c-7> 7gt
map <c-8> 8gt
map <c-9> 9gt
map <c-0> :tablast<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Autocall and key binding
autocmd BufWritePre *.rb,*.erb,*.py,*.js,*.html,*.txt,*.csv,*.tsv,*.jsx,*.ex,*.eex call <SID>StripTrailingWhitespaces()
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Strip annoying whitespaces
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

map <leader>j :Tjavascript
map <leader>v :Tview
map <leader>c :Tcontroller
map <leader>m :Tmodel
map <leader>k :SetLinuxFormatting<cr><cr>
map <leader>a :A<cr>
map <leader>z :R<cr>

" set mode paste in insert mode and line number
set pastetoggle=<C-p>
noremap <leader>n :set paste<CR>:put  *<CR>:set nopaste<CR>
nnoremap <leader>b :set number!<CR>

" switch lines upside down and reverse
nmap <silent> <C-k> [e
nmap <silent> <C-j> ]e

vmap <silent> <C-k> [egv
vmap <silent> <C-j> ]egv

" duplicate line, preserve cursor
noremap <C-d> mzyyp`z

" Convenient maps for vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gp :Git push<CR>

" Invisibles characters setup
nmap <Leader>L :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Toggler
nmap <script> <silent> <leader>w :call ToggleQuickfixList()<CR>

" erb mappings
" =============
" Surround.vim
" =============
" Use v or # to get a variable interpolation (inside of a string)}
" ysiw#   Wrap the token under the cursor in #{}
" v...s#  Wrap the selection in #{}
let g:surround_113 = "#{\r}"   " v
" Select text in an ERb file with visual mode and then press ysaw- or ysaw=
" Or yss- to do entire line.
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =

map <Leader>y <Plug>Yssurround=<cr>
map <Leader>i <Plug>Yssurround-<cr>
map <leader># ysiw#
imap <C-c> <CR><Esc>O

autocmd FileType ruby let b:surround_35 = "#{\r}"
autocmd FileType eruby let b:surround_35 = "#{\r}"

" Fix arrows for vim
if &term =~ '^screen' && exists('$TMUX')
  set mouse+=a
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
  " tmux will send xterm-style keys when xterm-keys is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
  map <Esc>OH <Home>
  map! <Esc>OH <Home>
  map <Esc>OF <End>
  map! <Esc>OF <End>
  execute "set <Insert>=\e[2;*~"
  execute "set <Delete>=\e[3;*~"
  execute "set <PageUp>=\e[5;*~"
  execute "set <PageDown>=\e[6;*~"
  execute "set <xF1>=\e[1;*P"
  execute "set <xF2>=\e[1;*Q"
  execute "set <xF3>=\e[1;*R"
  execute "set <xF4>=\e[1;*S"
  execute "set <F5>=\e[15;*~"
  execute "set <F6>=\e[17;*~"
  execute "set <F7>=\e[18;*~"
  execute "set <F8>=\e[19;*~"
  execute "set <F9>=\e[20;*~"
  execute "set <F10>=\e[21;*~"
  execute "set <F11>=\e[23;*~"
  execute "set <F12>=\e[24;*~"
endif

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

let $JS_CMD='node'
