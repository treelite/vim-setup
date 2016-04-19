" Treelite's VIM Setup
" Maintainer: treelite <c.xinle@gmail.com>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,cp936

execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible | filetype indent plugin on | syn on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set guioptions-=m
set guioptions-=T

set nobackup		" do not keep a backup file, use versions instead

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set autoindent
set expandtab 
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set nu
set linespace=4

set autochdir
set noerrorbells

" disable scratch window
set completeopt-=preview

colorscheme yytextmate
" Respect choice in .vimrc
let macvim_skip_colorscheme=1

set guifont=menlo:h12

nmap <S-H> :bp<CR>
nmap <S-L> :bn<CR>
nmap <D-k> :cp<CR>
nmap <D-j> :cn<CR>
nmap <F2> :nohlsearch<CR>
nmap <F3> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

" vim-markdown 配置
let g:vim_markdown_folding_disabled = 1

" multiple-cursors 配置
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key = '<M-n>'
let g:multi_cursor_prev_key = '<M-p>'
let g:multi_cursor_skip_key = '<M-x>'
let g:multi_cursor_quit_key = '<Esc>'

" neocomplete 配置
if v:version >= 704 && has('lua')
    " 禁用 AutoComplPop
    let g:acp_enableAtStartup = 0
    " 设置自启动
    let g:neocomplete#enable_at_startup = 1
    " 绑定 tab 为选择键
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
endif

" vim-airline 配置
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  au BufRead,BufNewFile *.text set filetype=mkd
  au BufRead,BufNewFile *.es6 set filetype=javascript
  " Remove trailing space
  au BufWritePre *.js :%s/\s\+$//e

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")
