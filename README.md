# My Dotfiles

---- 

I have been through a few itterations of dotfiles.  None of them really seemed to meet my needs, so I started from scratch.

### Requirements

---- 

Set zsh as your login shell:
`chsh -s $(which zsh)`

### Install

---- 

1. Clone to your machine:
	`git clone git://github.com/gregkellogg/dotfiles.git`

2. Install [RCM](https://github.com/thoughtbot/rcm)
	`brew tap thoughtbot/formulae`
	`brew install rcm`

3. Sync up your files
	`lsrc`
	`rcup -v`

4. When you need to add new files
	`mkrc ~/.tigrc`

5. There is more to it in the [tutorial](http://thoughtbot.github.io/rcm/rcm.7.html) or type 
	`man rcm`

### What's in it?

---- 

[vim](http://www.vim.org/)(http://www.vim.org/) configuration:
- [Vundle](https://github.com/gmarik/Vundle.vim.git)
- [Solarized](https://github.com/altercation/solarized.git) color theme
- [Pathogen](https://github.com/tpope/vim-pathogen.git)
- Much more, and I am still adding

[tmux](http://tmux.sourceforge.net) (http://www.vim.org/)
- A goo crash course can be found [here](http://robots.thoughtbot.com/a-tmux-crash-course)

[git](#)(http://git-scm.com/) configuration:

[Oh-My-ZSH](http://ohmyz.sh) (http://ohmyz.sh)

### License

---- 

This software is free and distributable under the [BSD](http://opensource.org/licenses/BSD-2-Clause) license.
