# Path to your oh-my-zsh installation.
export TERM=xterm-256color
export ZSH=$HOME/.zsh
export ZLE_RPROMPT_INDENT=0 

ZSH_THEME="solar-powered"

HIST_STAMPS="mm.dd.yyyy"

plugins=(colorize colored-man themes vim-interaction common-aliases\
vundle git battery brew brew-cask git-extras git-flow git-prompt github\
rails rake rvm ruby tmux tmuxinator cocoapods)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:."
export PATH="$PATH:$HOME/.bin"
#
# Compilation flags
export ARCHFLAGS="-arch x86_64"

export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
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
alias clear='osascript -e 'tell application "System Events" to keystroke "k" using command down''
zmodload zsh/complist
autoload -U compinit && compinit

### If you want zsh's completion to pick up new commands in $path automatically
### comment out the next line and un-comment the following 5 lines
#zstyle ':completion:::::' completer _complete _approximate
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1	# Because we didn't really complete anything
}
zstyle ':completion:::::' completer _force_rehash _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

############################################################################
# Powerline Config goes here                                               #
############################################################################

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
