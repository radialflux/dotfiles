let b:did_ftplugin = 1
set nocompatible
syntax enable
set backspace=indent,eol,start
set guioptions=R
set guioptions=e
set number

execute pathogen#infect()
set nobackup
set nowritebackup
set history=50
set ruler
set showcmd
set incsearch

" Don't use Ex mode, use Q for formatting
map Q gq

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
   syntax on
   set hlsearch
endif

set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
filetype plugin indent on


" \ is the leader character
let mapleader = ","



set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'ZenCoding.vim'
Plugin 'filetype-completion.vim'
Plugin 'filetype.vim'
Plugin 'zshr.vim'
Bundle 'Shougo/neocomplete'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'

call vundle#end()
let g:neocomplete#enable_at_startup = 1

set guifont=Sauce\ Code\ Powerline:h16

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_termcolors=256    "default value is 16
set background=dark
colorscheme solarized
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"



" +-----------------------------------------+
" | Powerline Config                        |
" +-----------------------------------------+
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2
let g:Powerline_symbols = "fancy"
let g:Powerline_theme = "solarized"
let g:Powerline_colorscheme = "solarized"
set noshowmode
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
" +-----------------------------------------+
" | End Powerline Config                    |
" +-----------------------------------------+



" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

let g:fuf_splitPathMatching=1

map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>

an 10.290 File.Toggle\ NerdTree :NERDTreeToggle<CR>

set go-=T

" +-----------------------------------------+
" | Folding and FileTypes                   |
" +-----------------------------------------+
set foldcolumn=2
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

augroup vimrc
  au BufNewFile,BufRead *.zsh-theme set syntax=zsh
  au BufNewFile,BufRead *.conf set syntax=sh
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END


if has("gui_macvim")
	let macvim_hig_shift_movement = 1
else
  set term=xterm-256color
endif
