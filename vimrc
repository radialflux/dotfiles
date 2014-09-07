set nocompatible     
syntax enable
filetype plugin indent off

execute pathogen#infect()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'Lokaltog/vim-powerline'
Bundle 'stephenmckinney/vim-solarized-powerline'

call vundle#end()
filetype plugin indent on   

let g:solarized_termcolors=256
set background=light
colorscheme solarized
let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized16_dark'
