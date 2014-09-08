set nocompatible     
syntax enable
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


" \ is the leader character
let mapleader = ","



set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bling/vim-airline'
Bundle 'edkolev/promptline.vim'

call vundle#end()


set guifont=Anonymice\ Powerline:h16

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_termcolors=256    "default value is 16
syntax enable
set background=dark
colorscheme solarized
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set noshowmode



" ------------------------------------------------------------------
" Powerline Config
" ------------------------------------------------------------------
"set laststatus=2
"let g:Powerline_symbols = "fancy"
"let g:Powerline_theme=""
"let g:Powerline_colorscheme='solarized'

" ------------------------------------------------------------------
" Airline Config
" ------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = 'solarizing'
set laststatus=2

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

