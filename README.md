# My Dotfiles

---- 

I have been through a few itterations of dotfiles.  None of them really seemed to meet my needs, so I started from scratch.

### Requirements

---- 
#### Powerline
Install [Powerline]

`$ pip install --user git+git://github.com/Lokaltog/powerline`

#### MacVim
Install [MacVim].  I create a formula for brew, this give finder functionality & a new icon to bring it up-to-date.

`$ brew tap gregkellogg/macvimsplitbrowser`
`$ brew install macvim-split-browser`

![MacVim](https://raw.githubusercontent.com/gregkellogg/dotfiles/master/images/MacVim.png)

MacVim on Powerline
#### Oh-My-ZSH
Set zsh as your login shell:

`$ chsh -s $(which zsh)`

![ZSH](https://raw.githubusercontent.com/gregkellogg/dotfiles/master/images/zsh.png)
ZSH on Powerline

#### Tmux
I mention Tmux below

`$ brew install tmux`

![MacVim](https://raw.githubusercontent.com/gregkellogg/dotfiles/master/images/tmux.png)
Tmux on Powerline

### Install

---- 

1. Clone to your machine:

	`$ git clone git://github.com/gregkellogg/dotfiles.git`

2. Install [RCM]

	`$ brew tap thoughtbot/formulae`
	`$ brew install rcm`

3. Sync up your files

	`$ lsrc`
	`$ rcup -v`

4. When you need to add new files

	`$ mkrc ~/.tigrc`

5. There is more to it in the [tutorial] or type 

	`$ man rcm`

### License

---- 

This software is free and distributable under the [BSD] license.
