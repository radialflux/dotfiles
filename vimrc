set nocompatible     
syntax enable
filetype plugin indent off
set backspace=indent,eol,start

execute pathogen#infect()
set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
   syntax on
   set hlsearch
endif

set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","



set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'stephenmckinney/vim-solarized-powerline'

call vundle#end()
filetype plugin indent on   

set guifont=Anonymice\ Powerline:h16

let g:solarized_termcolors=256
set background=dark
colorscheme solarized
let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_dark'


" Tab completion options
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

command -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
      	  exec "!open \"" . s:uri . "\""
  else
    	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

