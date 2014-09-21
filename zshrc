# Path to your oh-my-zsh installation.
export TERM=xterm-256color
export ZSH=$HOME/.zsh
export ZLE_RPROMPT_INDENT=0 

ZSH_THEME="solar-powered"

HIST_STAMPS="dd.mm.yyyy"

plugins=(battery brew brew-cask git git-extras git-flow git-prompt git-hubflow git-remote-branch brew install bundler bower coffee brew-cask rails rake rbenv ruby gem cocoapods terminalapp urltools web-search themes wp-cli xcode gitfast last-working-dir marked2 node npm osxpip rails rake-fast sudo systemadmin systemmd)

source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:."
export PATH="$PATH:$HOME/.bin"
export ARCHFLAGS="-arch x86_64"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias mvim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vi="/Applications/MacVim.app/Contents/MacOS/MacVim"
alias v="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias zshconfig="mvim ~/.zshrc"
alias dev="cd ~/Documents/Development"
alias gs='git status'
alias dots='cd ~/.dotfiles'
alias sysconfigs="vi -O ~/Documents/Projects/sysconfigs.session"
alias mdfind='mdfind -interpret $1'
alias clear="osascript -e 'if application \"Terminal\" is frontmost then tell application \"System Events\" to keystroke \"k\" using command down'"

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

